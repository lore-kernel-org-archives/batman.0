Return-Path: <gibsonsg91921@yahoo.com>
Message-ID: <1344359893.8678.YahooMailClassic@web162701.mail.bf1.yahoo.com>
Date: Tue, 7 Aug 2012 10:18:13 -0700 (PDT)
From: adam wiz <gibsonsg91921@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [B.A.T.M.A.N.] trouble setting up my mesh
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
To: b.a.t.m.a.n@lists.open-mesh.org

I am having some trouble setting up batman-adv for my mesh. I can get each access point to see the other using "batctl o" but I am not able to route messages between my client devices. I think there is something wrong with my bridging.

Here is the nature of my testbed:

2 Pandaboards 
running Ubuntu 12.04. They are connected to each other with wired 
Ethernet (eth0) and wireless ad-hoc (wlan1). wlan0 is set up as an 
access point using hostapd and udhcpd.

2 client Android phones, 
one connected to each access point. Using the Scripting Layer for 
Android app, they are running Python scripts. One is set to receive UDP 
messages, and the other is hardcoded to send UDP messages at a 
2-per-second clip to the IP address of the receiver. 

In setting up batman-adv, I run these commands:

sudo modprobe batman-adv
sudo batctl if add eth0
sudo batctl if add wlan1
sudo ifconfig eth0 0.0.0.0 mtu 1528
sudo ifconfig wlan1 0.0.0.0 mtu 1528
sudo ifconfig bat0 10.50.0.x (x being a unique number for each access point) netmask 255.255.0.0 up

At this point, and after any modification to bat0, I receive several instances of the error message: "bat0: hw csum failure." However, when I run "batctl o" I am able to see the MAC addresses of the opposite access point's eth0 and wlan1 interfaces, indicating so far so good. I can even ping the opposite board with a regular ping of their bat0 IP address. My difficulty is getting the access points to share HNA messages that show routes to their respective client devices. I can capably use batmand for such a task (sudo batmand -a 10.x.0.0/16 -d 1 eth0 wlan1) because the -a is easy for announcing the wlan0 network. How do I perform a similar task using this architecture?

Regards,
Adam
