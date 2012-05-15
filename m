Return-Path: <trizonelabs@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1337099068.2951.8.camel@E-PC-JJ>
References: <1337010808.2814.70.camel@E-PC-JJ>
	<20120514184254.f79056e44db765d4f85b4f75@gmx.net>
	<CAJuY50ycsfyTGfKHJ0RR8T8z-wA4cqRnhJn_DB1v+MvbWCPv6Q@mail.gmail.com>
	<1337099068.2951.8.camel@E-PC-JJ>
Date: Tue, 15 May 2012 21:43:56 +0300
Message-ID: <CAJuY50w99_iHwoNSE_iw9q80H7NTcghQ09Vn-bOgb5-B3W4sSA@mail.gmail.com>
From: 3zl Trizonelabs <trizonelabs@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Some problems with batman-adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

here's the data of my Openwrt at the VM i have at hand :


Openwrt ATTITUDE ADJUSTMENT (bleeding edge, r31151)

# uname -a
Linux e64f14 2.6.39.4 #2 Fri Mar 30 18:44:22 BST 2012 i686 GNU/Linux
#

# lsmod | grep rt73
rt73usb                20320  0
rt2x00usb               6012  1 rt73usb
rt2x00lib              25052  2 rt73usb,rt2x00usb
usbcore                85712  6 uhci_hcd,ohci_hcd,ehci_hcd,rt73usb,rt2x00usb
crc_itu_t                892  1 rt73usb
#
/lib/firmware/rt73.bin
#
# cat /etc/config/wireless

config wifi-device 'phy0'
        option phy 'phy0'
        option type 'mac80211'
        option channel '1'

config wifi-iface
        option device 'phy0'
        option mode 'adhoc'
        option ssid 'BRUCE-MESH'
        option bssid '02:AF:FE:00:11:22'

cat /etc/config/network

config interface 'lan'
        option ifname 'bat0'
        option type 'bridge'
        option proto 'dhcp'

#
#iwconfig

wlan0     IEEE 802.11bg  ESSID:"BRUCE-MESH"
          Mode:Ad-Hoc  Frequency:2.412 GHz  Cell: 02:AF:FE:00:11:22
          Tx-Power=20 dBm
          RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:on


#ifconfig wlan0 mtu 1528

##################################
for the Linux Slitaz setup i have to dig for it

for thorough test i would propose to run check-spripts + iperf on
non-encryptet channels

regards
3zl
