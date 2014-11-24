Return-Path: <martin@hundeboll.net>
Message-ID: <54738DB9.4070004@hundeboll.net>
Date: Mon, 24 Nov 2014 20:57:45 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <CAHmnjeAPeFU2oFyVM3=6H0R3_bu9EOV_3wRianjpHiqHHCwPvA@mail.gmail.com>
In-Reply-To: <CAHmnjeAPeFU2oFyVM3=6H0R3_bu9EOV_3wRianjpHiqHHCwPvA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------090109020500010104080604"
Subject: Re: [B.A.T.M.A.N.] problems while patching vde 2.3.2
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is a multi-part message in MIME format.
--------------090109020500010104080604
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

A long time ago, I updated the patch to vde-2.3.2, and fortunately still 
have it lying around...

Good luck!

// Martin

On 2014-11-24 19:18, Lucas Aimaretto wrote:
> Hi all,
>
> I'm trying to patch VDE just as suggested in [1] but I'm having
> trouble. I've downloaded VDE 2.3.2 from here [2] and the patches from
> here [1].
>
> I'm doing the following:
>
> lucas@test:~/batman-adv/
> script/vde$ tar zxvf vde2-2.3.2.tar.gz
> lucas@test:~/batman-adv/script/vde$ patch
> vde2-2.3.2/src/vde_switch/port.c < vde2-2.3.2_colour.patch
> patching file vde2-2.3.2/src/vde_switch/port.c
> patching file vde2-2.3.2/src/vde_switch/port.c
> Hunk #1 FAILED at 68.
> 1 out of 1 hunk FAILED -- saving rejects to file
> vde2-2.3.2/src/vde_switch/port.c.rej
>
> What is it that I'm doing wrong?
>
> Any hint is appreciated ...
>
> Regards!
>
> Lucas
>
> [1] - http://www.open-mesh.org/projects/open-mesh/wiki/Emulation
> [2] - http://sourceforge.net/projects/vde/files/vde2/2.3.2/
>

-- 
Kind Regards,
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C

+45 61 65 54 61
martin@hundeboll.net

--------------090109020500010104080604
Content-Type: text/x-patch;
 name="vde2-2.3.2_colour.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="vde2-2.3.2_colour.patch"

diff -urp a/src/vde_switch/port.c b/src/vde_switch/port.c
--- a/src/vde_switch/port.c	2011-11-23 17:41:17.000000000 +0100
+++ b/src/vde_switch/port.c	2012-07-05 11:12:10.325671913 +0200
@@ -96,6 +96,7 @@ struct endpoint {
 struct port {
 	struct endpoint *ep;
 	int flag;
+	int colour;
 	/* sender is already inside ms, but it needs one more memaccess */
 	int (*sender)(int fd_ctl, int fd_data, void *packet, int len, int port);
 	struct mod_support *ms;
@@ -153,6 +154,7 @@ static int alloc_port(unsigned int portn
 				EVENTOUT(DBGPORTNEW,i);
 
 				portv[i]=port;
+				port->colour=0;
 				port->ep=NULL;
 				port->user=port->group=port->curuser=-1;
 #ifdef FSTP
@@ -589,12 +591,12 @@ void handle_in_packet(struct endpoint *e
 			register int i;
 #ifndef VDE_PQ2
 			for(i = 1; i < numports; i++)
-				if((i != port) && (portv[i] != NULL))
+				if((i != port) && (portv[i] != NULL) && (!(pflag & COLOURFUL_TAG) || portv[i]->colour != portv[port]->colour))
 					SEND_PACKET_PORT(portv[i],i,packet,len);
 #else
 			void *tmpbuf=NULL;
 			for(i = 1; i < numports; i++)
-				if((i != port) && (portv[i] != NULL))
+				if((i != port) && (portv[i] != NULL) && (!(pflag & COLOURFUL_TAG) || portv[i]->colour != portv[port]->colour))
 					SEND_PACKET_PORT(portv[i],i,packet,len,&tmpbuf);
 #endif
 		} else { /* This is a switch, not a HUB! */
@@ -639,35 +641,35 @@ void handle_in_packet(struct endpoint *e
 					register int i;
 #ifndef VDE_PQ2
 					ba_FORALL(vlant[vlan].bctag,numports,
-							({if (i != port) SEND_PACKET_PORT(portv[i],i,packet,len);}),i);
+							({if (i != port && (!(pflag & COLOURFUL_TAG) || portv[i]->colour != portv[port]->colour)) SEND_PACKET_PORT(portv[i],i,packet,len);}),i);
 					packet=TAG2UNTAG(packet,len);
 					ba_FORALL(vlant[vlan].bcuntag,numports,
-							({if (i != port) SEND_PACKET_PORT(portv[i],i,packet,len);}),i);
+							({if (i != port && (!(pflag & COLOURFUL_TAG) || portv[i]->colour != portv[port]->colour)) SEND_PACKET_PORT(portv[i],i,packet,len);}),i);
 #else
 					void *tmpbuft=NULL;
 					void *tmpbufu=NULL;
 					ba_FORALL(vlant[vlan].bctag,numports,
-							({if (i != port) SEND_PACKET_PORT(portv[i],i,packet,len,&tmpbuft);}),i);
+							({if (i != port && (!(pflag & COLOURFUL_TAG) || portv[i]->colour != portv[port]->colour)) SEND_PACKET_PORT(portv[i],i,packet,len,&tmpbuft);}),i);
 					packet=TAG2UNTAG(packet,len);
 					ba_FORALL(vlant[vlan].bcuntag,numports,
-							({if (i != port) SEND_PACKET_PORT(portv[i],i,packet,len,&tmpbufu);}),i);
+							({if (i != port && (!(pflag & COLOURFUL_TAG) || portv[i]->colour != portv[port]->colour)) SEND_PACKET_PORT(portv[i],i,packet,len,&tmpbufu);}),i);
 #endif
 				} else { /* untagged */
 					register int i;
 #ifndef VDE_PQ2
 					ba_FORALL(vlant[vlan].bcuntag,numports,
-							({if (i != port) SEND_PACKET_PORT(portv[i],i,packet,len);}),i);
+							({if (i != port && (!(pflag & COLOURFUL_TAG) || portv[i]->colour != portv[port]->colour)) SEND_PACKET_PORT(portv[i],i,packet,len);}),i);
 					packet=UNTAG2TAG(packet,vlan,len);
 					ba_FORALL(vlant[vlan].bctag,numports,
-							({if (i != port) SEND_PACKET_PORT(portv[i],i,packet,len);}),i);
+							({if (i != port && (!(pflag & COLOURFUL_TAG) || portv[i]->colour != portv[port]->colour)) SEND_PACKET_PORT(portv[i],i,packet,len);}),i);
 #else
 					void *tmpbufu=NULL;
 					void *tmpbuft=NULL;
 					ba_FORALL(vlant[vlan].bcuntag,numports,
-							({if (i != port) SEND_PACKET_PORT(portv[i],i,packet,len,&tmpbufu);}),i);
+							({if (i != port && (!(pflag & COLOURFUL_TAG) || portv[i]->colour != portv[port]->colour)) SEND_PACKET_PORT(portv[i],i,packet,len,&tmpbufu);}),i);
 					packet=UNTAG2TAG(packet,vlan,len);
 					ba_FORALL(vlant[vlan].bctag,numports,
-							({if (i != port) SEND_PACKET_PORT(portv[i],i,packet,len,&tmpbuft);}),i);
+							({if (i != port && (!(pflag & COLOURFUL_TAG) || portv[i]->colour != portv[port]->colour)) SEND_PACKET_PORT(portv[i],i,packet,len,&tmpbuft);}),i);
 #endif
 				}
 			}
@@ -679,35 +681,47 @@ void handle_in_packet(struct endpoint *e
 #ifndef VDE_PQ2
 				if (tagged) {
 					if (portv[tarport]->vlanuntag==vlan) { /* TAG->UNTAG */
-						packet = TAG2UNTAG(packet,len);
-						SEND_PACKET_PORT(portv[tarport],tarport,packet,len);
+						if (!(pflag & COLOURFUL_TAG) || portv[tarport]->colour != portv[port]->colour) {
+							packet = TAG2UNTAG(packet,len);
+							SEND_PACKET_PORT(portv[tarport],tarport,packet,len);
+						}
 					} else {                               /* TAG->TAG */
-						SEND_PACKET_PORT(portv[tarport],tarport,packet,len);
+						if (!(pflag & COLOURFUL_TAG) || portv[tarport]->colour != portv[port]->colour)
+							SEND_PACKET_PORT(portv[tarport],tarport,packet,len);
 					}
 				} else {
 					if (portv[tarport]->vlanuntag==vlan) { /* UNTAG->UNTAG */
-						SEND_PACKET_PORT(portv[tarport],tarport,packet,len);
+						if (!(pflag & COLOURFUL_TAG) || portv[tarport]->colour != portv[port]->colour)
+							SEND_PACKET_PORT(portv[tarport],tarport,packet,len);
 					} else {                              /* UNTAG->TAG */
-						packet = UNTAG2TAG(packet,vlan,len);
-						SEND_PACKET_PORT(portv[tarport],tarport,packet,len);
+						if (!(pflag & COLOURFUL_TAG) || portv[tarport]->colour != portv[port]->colour) {
+							packet = UNTAG2TAG(packet,vlan,len);
+							SEND_PACKET_PORT(portv[tarport],tarport,packet,len);
+						}
 					}
 				}
 #else
 				if (tagged) {
 					void *tmpbuf=NULL;
 					if (portv[tarport]->vlanuntag==vlan) { /* TAG->UNTAG */
-						packet = TAG2UNTAG(packet,len);
-						SEND_PACKET_PORT(portv[tarport],tarport,packet,len,&tmpbuf);
+						if (!(pflag & COLOURFUL_TAG) || portv[tarport]->colour != portv[port]->colour) {
+							packet = TAG2UNTAG(packet,len);
+							SEND_PACKET_PORT(portv[tarport],tarport,packet,len,&tmpbuf);
+						}
 					} else {                               /* TAG->TAG */
-						SEND_PACKET_PORT(portv[tarport],tarport,packet,len,&tmpbuf);
+						if (!(pflag & COLOURFUL_TAG) || portv[tarport]->colour != portv[port]->colour)
+							SEND_PACKET_PORT(portv[tarport],tarport,packet,len,&tmpbuf);
 					}
 				} else {
 					void *tmpbuf=NULL;
 					if (portv[tarport]->vlanuntag==vlan) { /* UNTAG->UNTAG */
-						SEND_PACKET_PORT(portv[tarport],tarport,packet,len,&tmpbuf);
+						if (!(pflag & COLOURFUL_TAG) || portv[tarport]->colour != portv[port]->colour)
+							SEND_PACKET_PORT(portv[tarport],tarport,packet,len,&tmpbuf);
 					} else {                              /* UNTAG->TAG */
-						packet = UNTAG2TAG(packet,vlan,len);
-						SEND_PACKET_PORT(portv[tarport],tarport,packet,len,&tmpbuf);
+						if (!(pflag & COLOURFUL_TAG) || portv[tarport]->colour != portv[port]->colour) {
+							packet = UNTAG2TAG(packet,vlan,len);
+							SEND_PACKET_PORT(portv[tarport],tarport,packet,len,&tmpbuf);
+						}
 					}
 				}
 #endif
@@ -722,6 +736,7 @@ static int showinfo(FILE *fd)
 {
 	printoutc(fd,"Numports=%d",numports);
 	printoutc(fd,"HUB=%s",(pflag & HUB_TAG)?"true":"false");
+	printoutc(fd,"COLOURFUL=%s",(pflag & COLOURFUL_TAG)?"true":"false");
 #ifdef PORTCOUNTERS
 	printoutc(fd,"counters=true");
 #else
@@ -921,6 +936,19 @@ static int epqlen(char *arg)
 }
 #endif
 
+static int portsetcolour(char *arg) 
+{
+	int port,colour; 
+	if (sscanf(arg,"%i %i",&port,&colour) != 2) 
+		return EINVAL; 
+	if (port < 0 || port >= numports) 
+		return EINVAL; 
+	if (portv[port] == NULL) 
+		return ENXIO; 
+	portv[port]->colour= colour; 
+	return 0; 
+}
+
 static char *port_getuser(uid_t uid)
 {
 	static char buf[6];
@@ -971,6 +999,7 @@ static int print_port(FILE *fd,int i,int
 		printoutc(fd," IN:  pkts %10lld          bytes %20lld",portv[i]->pktsin,portv[i]->bytesin);
 		printoutc(fd," OUT: pkts %10lld          bytes %20lld",portv[i]->pktsout,portv[i]->bytesout);
 #endif
+		printoutc(fd," colour:   %10d",portv[i]->colour);
 		for (ep=portv[i]->ep; ep != NULL; ep=ep->next) {
 			printoutc(fd,"  -- endpoint ID %04d module %-12s: %s",ep->fd_ctl,
 					portv[i]->ms->modname,(ep->descr)?ep->descr:"no endpoint description");
@@ -1053,12 +1082,21 @@ static int portsethub(int val)
 #ifdef FSTP
 		fstpshutdown();
 #endif
-		portflag(P_SETFLAG,HUB_TAG);
+		portflag(P_ADDFLAG,HUB_TAG);
 	} else
 		portflag(P_CLRFLAG,HUB_TAG);
 	return 0;
 }
 
+static int portsetcolourful(int val) 
+{
+	if (val) {
+		portflag(P_ADDFLAG,COLOURFUL_TAG);
+	} else
+		portflag(P_CLRFLAG,COLOURFUL_TAG);
+	return 0;
+}
+
 static int portsetvlan(char *arg)
 {
 	int port,vlan;
@@ -1339,6 +1377,7 @@ static struct comlist cl[]={
 	{"port/setnumports","N","set the number of ports",portsetnumports,INTARG},
 	/*{"port/setmacaddr","MAC","set the switch MAC address",setmacaddr,STRARG},*/
 	{"port/sethub","0/1","1=HUB 0=switch",portsethub,INTARG},
+	{"port/setcolourful","0/1","1=colourful 0=no colour",portsetcolourful,INTARG},
 	{"port/setvlan","N VLAN","set port VLAN (untagged)",portsetvlan,STRARG},
 	{"port/createauto","","create a port with an automatically allocated id (inactive|notallocatable)",portcreateauto,NOARG|WITHFILE},
 	{"port/create","N","create the port N (inactive|notallocatable)",portcreate,INTARG},
@@ -1346,6 +1385,7 @@ static struct comlist cl[]={
 	{"port/allocatable","N 0/1","Is the port allocatable as unnamed? 1=Y 0=N",portallocatable,STRARG},
 	{"port/setuser","N user","access control: set user",portsetuser,STRARG},
 	{"port/setgroup","N user","access control: set group",portsetgroup,STRARG},
+	{"port/setcolour","N COLOUR","change colour of port",portsetcolour,STRARG},
 	{"port/epclose","N ID","remove the endpoint port N/id ID",epclose,STRARG},
 #ifdef VDE_PQ2
 	{"port/defqlen","LEN","set the default queue length for new ports",defqlen,INTARG},
diff -urp a/src/vde_switch/port.h b/src/vde_switch/port.h
--- a/src/vde_switch/port.h	2011-11-23 17:41:17.000000000 +0100
+++ b/src/vde_switch/port.h	2012-07-05 01:58:39.788912257 +0200
@@ -20,7 +20,7 @@ struct ethheader {
 
 struct packet {
 	struct ethheader header;
-  unsigned char data[1504]; /*including trailer, IF ANY */
+  unsigned char data[1604]; /*including trailer, IF ANY */
 };
 
 struct bipacket {
@@ -68,6 +68,7 @@ int portflag(int op, int f);
 #define P_CLRFLAG 3
 
 #define HUB_TAG 0x1
+#define COLOURFUL_TAG 0x2
 
 void port_init(int numports);
 

--------------090109020500010104080604--
