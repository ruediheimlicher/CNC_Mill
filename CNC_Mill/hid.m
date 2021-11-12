//
//  HID.c
//  USB_Stepper
//
//  Created by Ruedi Heimlicher on 30.Juli.11.
//  Copyright 2011 Skype. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <IOKit/IOKitLib.h>
#include <IOKit/hid/IOHIDLib.h>
#include <IOKit/usb/IOUSBLib.h>
#include <IOKit/hid/IOHIDBase.h>



//#include "hid.h"
#import <Cocoa/Cocoa.h>


#define BUFFER_SIZE 64
#define USBATTACHED           5
#define USBREMOVED            6

// https://stackoverflow.com/questions/12419161/post-a-notification-in-c-file


//#define printf(...) // comment this out to get lots of info printed

static IONotificationPortRef    gNotifyPort;
static io_iterator_t             gAddedIter;

static int     attach_called = 0;
static int     detach_called = 0;
// a list of all opened HID devices, so the caller can
// simply refer to them by number
typedef struct hid_struct hid_t;
typedef struct buffer_struct buffer_t;
static hid_t *first_hid = NULL;
static hid_t *last_hid = NULL;
struct hid_struct 
{
   IOHIDDeviceRef ref;
   int open;
   uint8_t buffer[BUFFER_SIZE];
   buffer_t *first_buffer;
   buffer_t *last_buffer;
   struct hid_struct *prev;
   struct hid_struct *next;
};
struct buffer_struct {
   struct buffer_struct *next;
   uint32_t len;
   uint8_t buf[BUFFER_SIZE];
};

int hid_usbstatus=0;
int rawhid_recv(int num, void *buf, int len, int timeout);

// private functions, not intended to be used from outside this file

static void add_hid(hid_t *);
static hid_t * get_hid(int);
static void free_all_hid(void);
static void hid_close(hid_t *);
static void attach_callback(void *, IOReturn, void *, IOHIDDeviceRef);
static void detach_callback(void *, IOReturn, void *hid_mgr, IOHIDDeviceRef dev);
static void timeout_callback(CFRunLoopTimerRef, void *);
static void input_callback(void *, IOReturn, void *, IOHIDReportType,uint32_t, uint8_t *, CFIndex);

const int BufferSize(void)
{
   return BUFFER_SIZE;
}


int rawhid_recv(int num, void *buf, int len, int timeout)
{
   //fprintf(stderr,"rawhid_recv start len: %d\n",len);
   //fprintf(stderr,"rawhid_recv start \n");
   hid_t *hid;
   buffer_t *b;
   CFRunLoopTimerRef timer=NULL;
   CFRunLoopTimerContext context;
   int ret=0, timeout_occurred=0;
   
   if (len < 1) return 0;
   hid = get_hid(num);
   if (!hid || !hid->open) return -1;
   if ((b = hid->first_buffer) != NULL)
   {
      if (len > b->len) len = b->len;
      memcpy(buf, b->buf, len);
      hid->first_buffer = b->next;
      free(b);
      // fprintf(stderr,"rawhid_recv A len: %d\n\n",len);
      return len;
   }
   memset(&context, 0, sizeof(context));
   context.info = &timeout_occurred;
   timer = CFRunLoopTimerCreate(NULL, CFAbsoluteTimeGetCurrent() +(double)timeout / 1000.0, 0, 0, 0, timeout_callback, &context);
   CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopDefaultMode);
   while (1) {
      CFRunLoopRun();
      if ((b = hid->first_buffer) != NULL) {
         if (len > b->len) len = b->len;
         memcpy(buf, b->buf, len);
         hid->first_buffer = b->next;
         free(b);
         ret = len;
         break;
      }
      if (!hid->open) {
         //printf("rawhid_recv, device not open\n");
         ret = -1;
         break;
      }
      if (timeout_occurred) break;
   }
   CFRunLoopTimerInvalidate(timer);
   CFRelease(timer);
   //fprintf(stderr,"rawhid_recv ret: %d\n",ret);
   return ret;
   
}




//
static void add_hid(hid_t *h)
{
   
   //   fprintf(stderr, "add_hid\n");
   //IOHIDDeviceRef* r= &h->ref;
   
   CFTypeRef prod = IOHIDDeviceGetProperty(h->ref, CFSTR(kIOHIDProductKey));
   const char* prodstr = CFStringGetCStringPtr(prod, kCFStringEncodingMacRoman);
   //   fprintf(stderr,"prodstr: %s\n",prodstr);
   
   
   CFTypeRef prop= IOHIDDeviceGetProperty(h->ref,CFSTR(kIOHIDManufacturerKey));
   //CFStringRef manu = (CFStringRef)prop;
   const char* manustr = CFStringGetCStringPtr(prop, kCFStringEncodingMacRoman);
   //   fprintf(stderr,"manustr: %s\n",manustr);
   
   if (!first_hid || !last_hid) 
   {
      first_hid = last_hid = h;
      h->next = h->prev = NULL;
      return;
   }
   last_hid->next = h;
   h->prev = last_hid;
   h->next = NULL;
   last_hid = h;
}


static hid_t * get_hid(int num)
{
   hid_t *p;
   for (p = first_hid; p && num > 0; p = p->next, num--) ;
   return p;
}


static void free_all_hid(void)
{
   hid_t *p, *q;
   
   for (p = first_hid; p; p = p->next) 
   {
      hid_close(p);
   }
   p = first_hid;
   while (p) {
      q = p;
      p = p->next;
      free(q);
   }
   first_hid = last_hid = NULL;
}

const char* get_manu()
{
   
   hid_t * cnc = get_hid(0);
   if (cnc)
   {
      CFTypeRef manu= IOHIDDeviceGetProperty(cnc->ref,CFSTR(kIOHIDManufacturerKey));
      //CFStringRef manu = (CFStringRef)prop;
      
      const char* manustr = CFStringGetCStringPtr(manu, kCFStringEncodingMacRoman);
      //fprintf(stderr,"manustr: %s\n",manustr);   
      return  manustr; 
   }
   else 
   {
      return "Kein USB-Device vorhanden\n";
   }
   
}


const char* get_prod()
{
   hid_t * cnc = get_hid(0);
   if (cnc)
   {
      CFTypeRef prod= IOHIDDeviceGetProperty(cnc->ref,CFSTR(kIOHIDProductKey));
      //CFStringRef manu = (CFStringRef)prop;
      const char* prodstr = CFStringGetCStringPtr(prod, kCFStringEncodingMacRoman);
      //fprintf(stderr,"prodstr: %s\n",prodstr);
      
      return  prodstr; 
   }
   else 
   {
      return "***\n";
   }
}

int getX()
{
   return 13;
}


//  rawhid_send - send a packet
//    Inputs:
//   num = device to transmit to (zero based)
//   buf = buffer containing packet to send
//   len = number of bytes to transmit
//   timeout = time to wait, in milliseconds
//    Output:
//   number of bytes sent, or -1 on error
//
int rawhid_send(int num, uint8_t *buf, int len, int timeout)
{
   //fprintf(stderr,"rawhid_send num: %d\n",num);
   hid_t *hid;
   int result=-100;
   // fprintf(stderr,"rawhid_send a len: %d\n",len);
   // fprintf(stderr,"rawhid_send a buf 0: %d\n",(uint8_t)buf[0]);
   hid = get_hid(num);
   if (!hid || !hid->open) return -1;
   //fprintf(stderr,"rawhid_send A\n");
   //#if 1
#warning "Send timeout not implemented on MACOSX"
   IOReturn ret = IOHIDDeviceSetReport(hid->ref, kIOHIDReportTypeOutput, 0, buf, (CFIndex)len);
   result = (ret == kIOReturnSuccess) ? len : -1;
   //  fprintf(stderr,"rawhid_send B result: %d\n",result);
   //#endif
#if 0
   // No matter what I tried this never actually sends an output
   // report and output_callback never gets called.  Why??
   // Did I miss something?  This is exactly the same params as
   // the sync call that works.  Is it an Apple bug?
   // (submitted to Apple on 22-sep-2009, problem ID 7245050)
   //
   //fprintf(stderr,"rawhid_send C\n");
   IOHIDDeviceScheduleWithRunLoop(hid->ref, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
   // should already be scheduled with run loop by attach_callback,
   // sadly this doesn't make any difference either way
   //
   IOHIDDeviceSetReportWithCallback(hid->ref, kIOHIDReportTypeOutput,
                                    0, buf, len, (double)timeout / 1000.0, output_callback, &result);
   //fprintf(stderr,"rawhid_send D\n");
   while (1) 
   {
      fprintf(stderr,"enter run loop (send)\n");
      CFRunLoopRun();
      fprintf(stderr,"leave run loop (send)\n");
      if (result > -100) break;
      if (!hid->open) 
      {
         result = -1;
         break;
      }
   }
#endif
   // fprintf(stderr,"rawhid_send end result: %d\n",result);
   return result;
}


//  rawhid_open - open 1 or more devices
//
//    Inputs:
//   max = maximum number of devices to open
//   vid = Vendor ID, or -1 if any
//   pid = Product ID, or -1 if any
//   usage_page = top level usage page, or -1 if any
//   usage = top level usage number, or -1 if any
//    Output:
//   actual number of devices opened
//

/*
func deviceAdded(refCon: UnsafePointer<Void>, iterator: io_iterator_t) {  
   if let usbDevice: io_service_t = IOIteratorNext(iterator)  
   {  
      let name = String()  
      let cs = (name as NSString).UTF8String  
      let deviceName: UnsafeMutablePointer<Int8> = UnsafeMutablePointer<Int8>(cs)  
      
      let kr: kern_return_t = IORegistryEntryGetName(usbDevice, deviceName)  
      if kr == KERN_SUCCESS {  
         let deviceNameAsCFString = CFStringCreateWithCString(kCFAllocatorDefault, deviceName,  
                                                              kCFStringEncodingASCII)  
         // if deviceNameAsCFString = XXX  
         // Do something  
         
      }  
      
   }  
   
}  
*/

void deviceAdded(void* refCon, io_iterator_t iterator )
{
   fprintf(stderr,"hid.m deviceAdded\n");
}

int rawhid_open(int max, int vid, int pid, int usage_page, int usage)
{
   //***
   kern_return_t           result;
   mach_port_t             masterPort;
   CFMutableDictionaryRef  matchingDict = NULL;
   CFRunLoopSourceRef      runLoopSource;
   
   
   //Create a master port for communication with the I/O Kit
   result = IOMasterPort(MACH_PORT_NULL, &masterPort);
   if (result || !masterPort)
   {
      return -1;
   }
   
   //To set up asynchronous notifications, create a notification port and
   //add its run loop event source to the programs run loop
   gNotifyPort = IONotificationPortCreate(masterPort);
   runLoopSource = IONotificationPortGetRunLoopSource(gNotifyPort);
   CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource,
                      kCFRunLoopDefaultMode);
   // ***
   /* 
    IOServiceAddMatchingNotification(
    gNotifyPort,
    kIOFirstMatchNotification,
    matchingDict,
    attach_callback, 
    NULL,
    &gAddedIter);
    */
   // ***
   
   static IOHIDManagerRef hid_manager=NULL;
   CFMutableDictionaryRef dict;
   CFNumberRef num;
   IOReturn ret;
   hid_t *p;
   int count=0;
   //fprintf(stderr,"fprintf rawhid_open\n");
   if (first_hid) free_all_hid();
   //printf("rawhid_open, max=%d\n", max);
   //fflush (stdout); 
   if (max < 1) return 0;
   // Start the HID Manager
   if (hid_manager) 
   {
      CFRelease(hid_manager);
      hid_manager = NULL;
   }

   // http://developer.apple.com/technotes/tn2007/tn2187.html
   if (!hid_manager) {
      hid_manager = IOHIDManagerCreate(kCFAllocatorDefault, kIOHIDOptionsTypeNone);
      if (hid_manager == NULL || CFGetTypeID(hid_manager) != IOHIDManagerGetTypeID()) {
         if (hid_manager) CFRelease(hid_manager);
         return 0;
      }
   }
   if (vid > 0 || pid > 0 || usage_page > 0 || usage > 0) 
   {
      // Tell the HID Manager what type of devices we want
      dict = CFDictionaryCreateMutable(kCFAllocatorDefault, 0,
                                       &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
      if (!dict) return 0;
      if (vid > 0) 
      {
         num = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &vid);
         CFDictionarySetValue(dict, CFSTR(kIOHIDVendorIDKey), num);
         CFRelease(num);
      }
      if (pid > 0) 
      {
         num = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &pid);
         CFDictionarySetValue(dict, CFSTR(kIOHIDProductIDKey), num);
         CFRelease(num);
      }
      if (usage_page > 0) 
      {
         num = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &usage_page);
         CFDictionarySetValue(dict, CFSTR(kIOHIDPrimaryUsagePageKey), num);
         CFRelease(num);
      }
      if (usage > 0) 
      {
         num = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &usage);
         CFDictionarySetValue(dict, CFSTR(kIOHIDPrimaryUsageKey), num);
         CFRelease(num);
      }
      IOHIDManagerSetDeviceMatching(hid_manager, dict);
      CFRelease(dict);
   } 
   else 
   {
      IOHIDManagerSetDeviceMatching(hid_manager, NULL);
   }
   // set up a callbacks for device attach & detach
   IOHIDManagerScheduleWithRunLoop(hid_manager, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
   IOHIDManagerRegisterDeviceMatchingCallback(hid_manager, attach_callback, NULL);
   IOHIDManagerRegisterDeviceRemovalCallback(hid_manager, detach_callback, NULL);
   ret = IOHIDManagerOpen(hid_manager, kIOHIDOptionsTypeNone);
   if (ret != kIOReturnSuccess) 
   {
      IOHIDManagerUnscheduleFromRunLoop(hid_manager,
                                        CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
      CFRelease(hid_manager);
      return 0;
   }
   //   printf("run loop\n");
   // let it do the callback for all devices
   while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) == kCFRunLoopRunHandledSource) ;
   // count up how many were added by the callback
   for (p = first_hid; p; p = p->next) count++;
   
   hid_usbstatus=count;
   return count;
}
int rawhid_open_a(int max, int vid, int pid, int usage_page, int usage)
{
   //***
   kern_return_t           result;
   mach_port_t             masterPort;
   CFMutableDictionaryRef  matchingDict = NULL;
   CFRunLoopSourceRef      runLoopSource;
    
   //Create a master port for communication with the I/O Kit
   result = IOMasterPort(MACH_PORT_NULL, &masterPort);
   if (result || !masterPort)
   {
      return -1;
   }
   //To set up asynchronous notifications, create a notification port and
   //add its run loop event source to the programs run loop
   gNotifyPort = IONotificationPortCreate(masterPort);
   runLoopSource = IONotificationPortGetRunLoopSource(gNotifyPort);
   CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource,
                      kCFRunLoopDefaultMode);
   // ***
   /* 
    IOServiceAddMatchingNotification(
    gNotifyPort,
    kIOFirstMatchNotification,
    matchingDict,
    attach_callback, 
    NULL,
    &gAddedIter);
    */
   // ***
   
   static IOHIDManagerRef hid_manager=NULL;
   CFMutableDictionaryRef dict;
   CFNumberRef num;
   IOReturn ret;
   hid_t *p;
   int count=0;
   //fprintf(stderr,"fprintf rawhid_open\n");
   if (first_hid) free_all_hid();
   //printf("rawhid_open, max=%d\n", max);
   //fflush (stdout); 
   if (max < 1) return 0;
   // Start the HID Manager
   
   if (hid_manager) 
   {
      CFRelease(hid_manager);
      hid_manager = NULL;
   }

   // http://developer.apple.com/technotes/tn2007/tn2187.html
   if (!hid_manager) 
   {
      hid_manager = IOHIDManagerCreate(kCFAllocatorDefault, kIOHIDOptionsTypeNone);
      if (hid_manager == NULL || CFGetTypeID(hid_manager) != IOHIDManagerGetTypeID()) {
         if (hid_manager) CFRelease(hid_manager);
         return 0;
      }
   }
   if (vid > 0 || pid > 0 || usage_page > 0 || usage > 0) {
      // Tell the HID Manager what type of devices we want
      dict = CFDictionaryCreateMutable(kCFAllocatorDefault, 0,
                                       &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
      if (!dict) return 0;
      if (vid > 0) 
      {
         num = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &vid);
         CFDictionarySetValue(dict, CFSTR(kIOHIDVendorIDKey), num);
         CFRelease(num);
      }
      if (pid > 0) 
      {
         num = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &pid);
         CFDictionarySetValue(dict, CFSTR(kIOHIDProductIDKey), num);
         CFRelease(num);
      }
      if (usage_page > 0) 
      {
         num = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &usage_page);
         CFDictionarySetValue(dict, CFSTR(kIOHIDPrimaryUsagePageKey), num);
         CFRelease(num);
      }
      if (usage > 0) 
      {
         num = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &usage);
         CFDictionarySetValue(dict, CFSTR(kIOHIDPrimaryUsageKey), num);
         CFRelease(num);
      }
      IOHIDManagerSetDeviceMatching(hid_manager, dict);
      CFRelease(dict);
   } 
   else 
   {
      IOHIDManagerSetDeviceMatching(hid_manager, NULL);
   }
   // set up a callbacks for device attach & detach
   IOHIDManagerScheduleWithRunLoop(hid_manager, CFRunLoopGetCurrent(),
                                   kCFRunLoopDefaultMode);
   IOHIDManagerRegisterDeviceMatchingCallback(hid_manager, attach_callback, NULL);
   IOHIDManagerRegisterDeviceRemovalCallback(hid_manager, detach_callback, NULL);
   ret = IOHIDManagerOpen(hid_manager, kIOHIDOptionsTypeNone);
   if (ret != kIOReturnSuccess) 
   {
      IOHIDManagerUnscheduleFromRunLoop(hid_manager,
                                        CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
      CFRelease(hid_manager);
      return 0;
   }
   //   printf("run loop\n");
   // let it do the callback for all devices
   while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) == kCFRunLoopRunHandledSource) ;
   // count up how many were added by the callback
   for (p = first_hid; p; p = p->next) count++;
   
   hid_usbstatus=count;
   return count;
}



static void hid_close(hid_t *hid)
{
   printf("hid_close hid->ref: %d",hid->open);
   if (hid->open > 0)
   {
      printf("hid_close return ");
      return;
   }
   if (!hid || !(hid->open == 1)|| !hid->ref) return;
   
   IOHIDDeviceUnscheduleFromRunLoop(hid->ref, CFRunLoopGetCurrent( ), kCFRunLoopDefaultMode);
   IOHIDDeviceClose(hid->ref, kIOHIDOptionsTypeNone);
   hid->ref = NULL;
}


int rawhid_status(void)
{
   //fprintf(stderr,"status: %d\n",hid_usbstatus);
   return hid_usbstatus;
}

int get_hid_usbstatus(void)
{
   //fprintf(stderr,"get_hid_usbstatus: %d\n",hid_usbstatus);
   return hid_usbstatus;
}

/*
 static void input_callback(void *context, IOReturn ret, void *sender,
 IOHIDReportType type, uint32_t id, uint8_t *data, CFIndex len)
 {
 buffer_t *n;
 hid_t *hid;
 
 //fprintf(stderr,"input_callback\n");
 if (ret != kIOReturnSuccess || len < 1) return;
 hid = context;
 if (!hid || hid->ref != sender) return;
 n = (buffer_t *)malloc(sizeof(buffer_t));
 if (!n) return;
 if (len > BUFFER_SIZE) len = BUFFER_SIZE;
 memcpy(n->buf, data, len);
 n->len = len;
 n->next = NULL;
 if (!hid->first_buffer || !hid->last_buffer) {
 hid->first_buffer = hid->last_buffer = n;
 } else {
 hid->last_buffer->next = n;
 hid->last_buffer = n;
 }
 CFRunLoopStop(CFRunLoopGetCurrent());
 }
 
 */

static void timeout_callback(CFRunLoopTimerRef timer, void *info)
{
   //fprintf(stderr,"timeout_callback\n");
   *(int *)info = 1;
   CFRunLoopStop(CFRunLoopGetCurrent());
}


void output_callback(void *context, IOReturn ret, void *sender,
                     IOHIDReportType type, uint32_t id, uint8_t *data, CFIndex len)
{
   fprintf(stderr,"output_callback, r=%d\n", ret);
   if (ret == kIOReturnSuccess) 
   {
      *(int *)context = (uint32_t)len;
   } else {
      // timeout if not success?
      *(int *)context = 0;
   }
   CFRunLoopStop(CFRunLoopGetCurrent());
}

static void input_callback(void *context, IOReturn ret, void *sender,
                           IOHIDReportType type, uint32_t id, uint8_t *data, CFIndex len)
{
   buffer_t *n;
   hid_t *hid;
   
   //fprintf(stderr,"input_callback\n");
   if (ret != kIOReturnSuccess || len < 1) return;
   hid = context;
   if (!hid || hid->ref != sender) return;
   n = (buffer_t *)malloc(sizeof(buffer_t));
   if (!n) return;
   if (len > BUFFER_SIZE) len = BUFFER_SIZE;
   memcpy(n->buf, data, len);
   n->len = (uint32_t)len;
   n->next = NULL;
   if (!hid->first_buffer || !hid->last_buffer) {
      hid->first_buffer = hid->last_buffer = n;
   } else {
      hid->last_buffer->next = n;
      hid->last_buffer = n;
   }
   //free(n);
   CFRunLoopStop(CFRunLoopGetCurrent());
}


static void detach_callback(void *context, IOReturn r, void *hid_mgr, IOHIDDeviceRef dev)
{
   hid_t *p;
   NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];

   fprintf(stderr,"detach callback\n");
   
   hid_usbstatus=0;
   for (p = first_hid; p; p = p->next) {
      if (p->ref == dev) 
      {
         p->open = 0;
         CFRunLoopStop(CFRunLoopGetCurrent());
         NSDictionary* NotDic = [NSDictionary  dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:USBREMOVED],@"attach", nil];
         [nc postNotificationName:@"usb_attach" object:NULL userInfo:NotDic];

         return;
      }
   }

}


static void attach_callback(void *context, IOReturn r, void *hid_mgr, IOHIDDeviceRef dev)
{
   struct hid_struct *h;
   
   fprintf(stderr,"attach callback\n");
   //
   if (attach_called)
   {
      fprintf(stderr,"attach callback repeat: %d\n",attach_called);
      //return;
   }
   
   if (IOHIDDeviceOpen(dev, kIOHIDOptionsTypeNone) != kIOReturnSuccess) 
   {
      fprintf(stderr,"attach callback not kIOReturnSuccess\n");
    //  return;
   }
   else 
   {
      fprintf(stderr,"attach kIOReturnSuccess ist OK\n");
   }

   h = (hid_t *)malloc(sizeof(hid_t));
   if (!h) 
   {
      fprintf(stderr,"attach callback not h\n");
      return;
   }
   else 
   {
      fprintf(stderr,"attach callback hid_t ist OK\n");
   }
   memset(h, 0, sizeof(hid_t));
   
   IOHIDDeviceScheduleWithRunLoop(dev, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);   
   IOHIDDeviceRegisterInputReportCallback(dev, h->buffer, sizeof(h->buffer), input_callback, h);
   h->ref = dev;
   h->open = 1;
   
   add_hid(h);
   hid_usbstatus=1;
   attach_called++;
   /*
    r = rawhid_open(1, 0x16C0, 0x0480, 0xFFAB, 0x0200);
    if (r <= 0) 
    {
    fprintf(stderr,"no rawhid device found\n");
    }
    else
    {
    
    fprintf(stderr,"new rawhid device found\n");
    }
    */
   NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
   NSDictionary* NotDic = [NSDictionary  dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:USBATTACHED],@"attach", nil];
   [nc postNotificationName:@"usb_attach" object:NULL userInfo:NotDic];
}


int usb_present()
{
   CFMutableDictionaryRef matchingDict;
   io_iterator_t iter;
   kern_return_t kr;
   io_service_t device;
   int anzahl=0;
   
   // set up a matching dictionary for the class 
   matchingDict = IOServiceMatching(kIOUSBDeviceClassName);
   if (matchingDict == NULL)
   {
      return -1; // fail
   }
   
   // Now we have a dictionary, get an iterator.
   kr = IOServiceGetMatchingServices(kIOMasterPortDefault, matchingDict, &iter);
   if (kr != KERN_SUCCESS)
   {
      return -1;
   }
   
   // iterate 
   while ((device = IOIteratorNext(iter)))
   {
      //fprintf(stderr,"usb device: %d\n",device);
      // do something with device, eg. check properties 
      // ... 
      // And free the reference taken before continuing to the next item 
      IOObjectRelease(device);
      anzahl++;
   }
   
   // Done, release the iterator 
   //IOObjectRelase(iter);
   return anzahl;
}
