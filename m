Return-Path: <ditwal001@gmail.com>
From: "Walter Robert Ditzler" <ditwal001@gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPvMiqao58dPrVwIXxeghf4BAAAAAA==@gmail.com>
	<1773376.eftnT4ifSy@sven-desktop.home.narfation.org>
	<!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPNuGB5hMDtNhUs29egcVLUBAAAAAA==@gmail.com>
	<1794568.t7tZJ9NAC6@bentobox>
In-Reply-To: <1794568.t7tZJ9NAC6@bentobox>
Date: Wed, 6 Jun 2012 14:26:12 +0200
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAF6fjKGT24hLtxfi+jpGMQMBAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: de-ch
Subject: Re: [B.A.T.M.A.N.] bridging problem
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
To: 'Sven Eckelmann' <sven@narfation.org>, 'Antonio Quartulli' <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

hi sven,
hi antonio,

thanks a lot for your explanations which helped me finally to understand the
concept. it is that actually what i thought it should be, a transparent
layer 2 thing.

i mean i thought so, it must be possible to serve AP within 1 wireless nic
only! netherthenless i haven't succed to get it run.

But as sven mentioned that could and i beleive it must be a
hostapd/squeeze6.0.5 problem since my ethernet nic's onto the batman mesh
works perfectly.

only this thing with the bridging networks from the wlan's.

thanks walter.

(with madwifi)
***
root@srv-ldeb-basic1:/etc/hostapd# hostapd hostapd.conf
Configuration file: hostapd.conf
ioctl[SIOCSIWMODE]: Invalid argument
Could not set interface to master mode!
madwifi driver initialization failed.
ELOOP: remaining socket: sock=5 eloop_data=0x9f8baf0 user_data=(nil)
handler=0x8086f00
root@srv-ldeb-basic1:/etc/hostapd#
***

(with nl80211)
***
root@srv-ldeb-basic1:/etc/hostapd# hostapd hostapd.conf
Configuration file: hostapd.conf
ioctl[SIOCSIFFLAGS]: Name not unique on network
nl80211 driver initialization failed.
ELOOP: remaining socket: sock=5 eloop_data=0x9141a30 user_data=(nil)
handler=0x80863e0
root@srv-ldeb-basic1:/etc/hostapd#
***

hostapd.conf
***
interface=wlan0
bridge=br0
driver=nl80211 / madwifi
ssid=moses_test
channel=1
hw_mode=g
ieee80211n=1
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=123456123456123456123456
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
***

***
root@srv-ldeb-basic1:/etc/hostapd# iwconfig
gre0      no wireless extensions.

br0       no wireless extensions.

wlan0     IEEE 802.11abg  Mode:Master  Tx-Power=20 dBm
          Retry  long limit:7   RTS thr:off   Fragment thr:off
          Power Management:on

bat0      no wireless extensions.

lo        no wireless extensions.

eth0      no wireless extensions.

mesh0     IEEE 802.11abg  ESSID:"adradix_mesh"
          Mode:Ad-Hoc  Frequency:2.427 GHz  Cell: 02:12:34:56:78:9A
          Tx-Power=20 dBm
          Retry  long limit:7   RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:on

tunl0     no wireless extensions.

root@srv-ldeb-basic1:/etc/hostapd#
***




-----Original Message-----
From: Sven Eckelmann [mailto:sven@narfation.org] 
Sent: Mittwoch, 6. Juni 2012 08:59
To: Walter Robert Ditzler
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [B.A.T.M.A.N.] bridging problem

On Wednesday 06 June 2012 00:16:07 Walter Robert Ditzler wrote:
> hi sven,
> 
> thank you very much for your reply, in fact my email hasn't arrived as 
> wished!
> 
> attached i send you a pdf to have a look, if you dont mind, would be 
> very cool!
> 
> so what works:
> 1) lan to lan bridge (10.41.200.11 <> 10.41.200.12)
> 
> what i am too stupid to do:
> 1) attached wireless ad-hoc devices to give a dhcp lease

You need another vap/vif [1] adhoc device to serve such devices. This one
would have to run in 4addr mode to be able to get bridged. Usually you don't
do this because the client also needs to understand the 4addr mode.
Therefore, just create a master mode vap/vif and attach it to the bridge
(you get it into master mode using hostapd... please keep in mind that
squeeze's hostapd is buggy and maybe has problems with that setup).

> 2) that ex. a attached laptop has a address 10.41.200.71 > bridged 
> analogue tot he base lan
> 
> so my question is:
> 1) do i need 2 wireless network card for each batman host?

Not really. It could be a good idea to run the mesh on another frequency and
use another wlan device for this.

But the basic setup is really to create two interfaces (VAPs) for phy0 using
iw. One is added to bat0 (the adhoc one) and the other one (managed) is
transformed using hostapd in an master mode/AP interface and added to the
same bridge.

> 2) can i connect tot he batman mesh essid to get access the base lan?

Using non mesh aware clients? No.

batman-adv is a layer on top of the adhoc layer and clients that don't
understand batman-adv cannot decode this extra layer information.

Kind regards,
	Sven

[1] http://linuxwireless.org/en/users/Documentation/iw/vif/

