Return-Path: <austinxxh-ath9k@yahoo.com>
Message-ID: <97539.97811.qm@web55306.mail.re4.yahoo.com>
Date: Mon, 6 Jul 2009 13:02:03 -0700 (PDT)
From: xxiao <austinxxh-ath9k@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv and 11n speed
Reply-To: austinxxh-ath9k@yahoo.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>, elektra <onelektra@gmx.net>


Elektra,=0AYou're correct. I disabled batman-adv, the speed will still retu=
rn to 11g after a second IBSS board is up. that has something to do with ra=
te-discovery-under-IBSS for mac80211/ath9k I think.=0Athanks,=0Axxiao=0A=0A=
--- On Mon, 7/6/09, elektra <onelektra@gmx.net> wrote:=0A=0A> From: elektra=
 <onelektra@gmx.net>=0A> Subject: Re: [B.A.T.M.A.N.] batman-adv and 11n spe=
ed=0A> To: austinxxh-ath9k@yahoo.com, "The list for a Better Approach To Mo=
bile Ad-hoc Networking" <b.a.t.m.a.n@lists.open-mesh.net>=0A> Date: Monday,=
 July 6, 2009, 2:43 PM=0A> Hi xxiao -=0A> =0A> I guess your problem is not =
related to batman-adv - I would=0A> plea not=0A> guilty unless proven other=
wise.=A0 This looks like a=0A> driver issue. =0A> =0A> Batman doesn't force=
 your driver to use a certain 802.11=0A> mode or rate.=0A> It does send pro=
tocol messages as broadcasts of course, and=0A> those are=0A> usually sent =
at basic rate.=0A> =0A> Did you actually test performance in IBSS mode with=
out=0A> batman-adv=0A> running?=0A> =0A> Ath9k is pretty new and my guess i=
s that the driver hasn't=0A> experienced=0A> much testing in IBSS mode.=0A>=
 =0A> I'd like to suggest that you test the following:=0A> =0A> Restart you=
r wireless interfaces, set up IBSS mode. Don't=0A> start=0A> batman-adv.=0A=
> =0A> Send broadcasts (by sending ping to the networks broadcast=0A> addre=
ss for=0A> example) and check if the driver reports the same behaviour=0A> =
or not.=0A> =0A> Cheers,=0A> Elektra=0A> =0A> =0A> =0A> > I'm using Openwrt=
/compat-wireless-2009-06-25 on a=0A> AR7161 board. I'm using ath9k trying t=
o get 11n speed for=0A> batman-adv working. All code is from openwrt trunk.=
=0A> > =0A> > >From the debugfs of mac80211/ath9k, I can see=0A> under IBSS=
 mode, the rcstat reports speed up to 300mbps. I=0A> have batman-adv enable=
d.=0A> > =0A> > However after a second board with the same software=0A> boo=
ted up, both boards' rcstat output showed a speed of 11g=0A> only, an immed=
iate drop from 11n to 11g. It's like the=0A> second batman-adv somehow forc=
ed a 11g speed after it=0A> "talked" to the first batman-adv board.=0A> > =
=0A> > Any help is appreciated!=0A> > xxiao=0A> > =0A> > =0A> > Before the =
second batman-adv is booted up:=0A> > root@OpenWrt:/# cat /mnt/ath9k/phy0/r=
cstat =0A> >=A0 Rate=A0 =A0 =A0=0A> =A0=A0=A0Success=A0 Retries=A0 XRetries=
 PER=0A> > =0A> >=A0=A0=A01.0:=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=A0 =A0=
 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=0A> >=A0=A0=A02.0:=A0 =A0 =A0 =A0=0A> 0=A0 =
=A0 =A0 =A0 0=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=0A> >=A0=A0=A05.5:=A0 =
=A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=0A=
> >=A0 11.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=
=0A> =A0 =A0 0=0A> >=A0=A0=A06.0:=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=A0 =
=A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=0A> >=A0=A0=A09.0:=A0 =A0 =A0 =A0=0A> 0=
=A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=0A> >=A0 12.0:=A0 =
=A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A=
> >=A0 18.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=
=0A> =A0 =A0 0=0A> >=A0 24.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =
=A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 36.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =
=A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 48.0:=A0 =A0 =A0 =
=A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 5=
4.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =
=A0 0=0A> >=A0=A0=A06.5:=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=A0 =A0 =A0 =
=A0=0A> 0=A0 =A0 =A0 =A0 0=0A> >=A0 13.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =
=A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 19.5:=A0 =A0 =A0 =A0 0=
=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 26.0:=
=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 =
0=0A> >=A0 39.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =
=A0=0A> =A0 =A0 0=0A> >=A0 52.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =
=A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 58.5:=A0 =A0 =A0 =A0 0=A0 =A0=
=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 65.0:=A0 =A0 =
=A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=
=A0 13.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A>=
 =A0 =A0 0=0A> >=A0 26.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =
=A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 39.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =
=A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 52.0:=A0 =A0 =A0 =A0 0=
=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 78.0:=
=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 =
0=0A> > 104.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =
=A0=0A> =A0 =A0 0=0A> > 117.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0=
 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> > 130.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =
=A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 13.5:=A0 =A0 =A0 =
=A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 2=
7.5:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =
=A0 0=0A> >=A0 40.5:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=
=A0 =A0=0A> =A0 =A0 0=0A> >=A0 54.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=
=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 81.5:=A0 =A0 =A0 =A0 0=A0 =
=A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> > 108.0:=A0 =A0=
 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=
 121.5:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =
=A0 =A0 0=0A> > 135.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0=
 0=A0 =A0=0A> =A0 =A0 0=0A> > 150.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=
=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 27.0:=A0 =A0 =A0 =A0 0=A0 =
=A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 54.0:=A0 =
=A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A=
> >=A0 81.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=
=0A> =A0 =A0 0=0A> > 108.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =
=A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> > 162.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0=
 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> > 216.0:=A0 =A0 =A0 =A0 0=
=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> > 243.0:=A0=
 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=
=0A> > 270.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=
=0A> =A0 =A0 0=0A> > 300.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =
=A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> > =0A> > after the second batman-adv is =
up:=0A> > root@OpenWrt:/# cat /mnt/ath9k/phy0/rcstat =0A> >=A0 Rate=A0 =A0 =
=A0=0A> =A0=A0=A0Success=A0 Retries=A0 XRetries PER=0A> > =0A> >=A0=A0=A01.=
0:=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =A0 =
=A0 0=0A> >=A0=A0=A02.0:=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=A0 =A0 =A0 =
=A0=0A> 0=A0 =A0 =A0 =A0 0=0A> >=A0=A0=A05.5:=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =
=A0 =A0 0=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=0A> >=A0 11.0:=A0 =A0 =A0 =
=A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0=
=A0=A06.0:=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0=0A> 0=A0 =
=A0 =A0 =A0 0=0A> >=A0=A0=A09.0:=A0 =A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=A0 =
=A0 =A0 =A0=0A> 0=A0 =A0 =A0 =A0 0=0A> >=A0 12.0:=A0 =A0 =A0 =A0 0=A0 =A0=
=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 18.0:=A0 =A0 =
=A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=
=A0 24.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A>=
 =A0 =A0 0=0A> >=A0 36.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =
=A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 48.0:=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =
=A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> >=A0 54.0:=A0 =A0 =A0 =A0 0=
=A0 =A0=0A> =A0 =A0 0=A0 =A0 =A0 =A0 0=A0 =A0=0A> =A0 =A0 0=0A> > =0A> > On=
 both boards I have this:=0A> > root@OpenWrt:/# iwconfig=0A> > lo=A0 =A0 =
=A0 =A0 no wireless extensions.=0A> > =0A> > eth0=A0 =A0 =A0 no wireless ex=
tensions.=0A> > =0A> > eth1=A0 =A0 =A0 no wireless extensions.=0A> > =0A> >=
 br-lan=A0 =A0 no wireless extensions.=0A> > =0A> > wlan0=A0 =A0=A0=A0IEEE =
802.11abgn=A0=0A> ESSID:"xyz"=A0 =0A> >=A0 =A0 =A0 =A0=0A> =A0=A0=A0Mode:Ad=
-Hoc=A0 Frequency:2.432=0A> GHz=A0 Cell: 92:46:0A:A3:8B:39=A0=A0=A0=0A> >=
=A0 =A0 =A0 =A0=0A> =A0=A0=A0Tx-Power=3D27 dBm=A0=A0=A0=0A> >=A0 =A0 =A0 =
=A0=0A> =A0=A0=A0Retry=A0 long=0A> limit:7=A0=A0=A0RTS=0A> thr:off=A0=A0=A0=
Fragment thr:off=0A> >=A0 =A0 =A0 =A0=0A> =A0=A0=A0Encryption key:off=0A> >=
=A0 =A0 =A0 =A0 =A0=A0=A0Power=0A> Management:off=0A> >=A0 =A0 =A0 =A0 =A0=
=A0=A0Link=0A> Quality:0=A0 Signal level:0=A0 Noise level:0=0A> >=A0 =A0 =
=A0 =A0 =A0=A0=A0Rx=0A> invalid nwid:0=A0 Rx invalid crypt:0=A0 Rx invalid=
=0A> frag:0=0A> >=A0 =A0 =A0 =A0 =A0=A0=A0Tx=0A> excessive retries:0=A0 Inv=
alid=0A> misc:0=A0=A0=A0Missed beacon:0=0A> > =0A> > bat0=A0 =A0 =A0 no wir=
eless extensions.=0A> > =0A> > Here is the dmesg dump:=0A> > root@OpenWrt:/=
# dmesg=0A> > 30fe050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D83=
1da04a DA=3D831da044=0A> BSSID=3D831da050 (tx_last_beacon=3D1)=0A> > wlan0:=
 RX ProbeReq SA=3D8312204a DA=3D83122044=0A> BSSID=3D83122050 (tx_last_beac=
on=3D1)=0A> > wlan0: Sending ProbeResp to 838e1804=0A> > wlan0: RX ProbeReq=
 SA=3D8326804a DA=3D83268044=0A> BSSID=3D83268050 (tx_last_beacon=3D1)=0A> =
> wlan0: RX ProbeReq SA=3D8319e04a DA=3D8319e044=0A> BSSID=3D8319e050 (tx_l=
ast_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1604=0A> > wlan0: RX =
ProbeReq SA=3D831ac04a DA=3D831ac044=0A> BSSID=3D831ac050 (tx_last_beacon=
=3D1)=0A> > wlan0: RX ProbeReq SA=3D8309604a DA=3D83096044=0A> BSSID=3D8309=
6050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D831e204a DA=3D831e2=
044=0A> BSSID=3D831e2050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=
=3D831a204a DA=3D831a2044=0A> BSSID=3D831a2050 (tx_last_beacon=3D1)=0A> > w=
lan0: RX ProbeReq SA=3D832de04a DA=3D832de044=0A> BSSID=3D832de050 (tx_last=
_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8324604a DA=3D83246044=0A> BSSID=
=3D83246050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1604=
=0A> > wlan0: RX ProbeReq SA=3D832fc04a DA=3D832fc044=0A> BSSID=3D832fc050 =
(tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8337604a DA=3D83376044=
=0A> BSSID=3D83376050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D82=
c6804a DA=3D82c68044=0A> BSSID=3D82c68050 (tx_last_beacon=3D1)=0A> > wlan0:=
 RX ProbeReq SA=3D8329a04a DA=3D8329a044=0A> BSSID=3D8329a050 (tx_last_beac=
on=3D1)=0A> > wlan0: Sending ProbeResp to 838e1004=0A> > wlan0: RX ProbeReq=
 SA=3D830e804a DA=3D830e8044=0A> BSSID=3D830e8050 (tx_last_beacon=3D1)=0A> =
> wlan0: RX ProbeReq SA=3D830ec04a DA=3D830ec044=0A> BSSID=3D830ec050 (tx_l=
ast_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1604=0A> > wlan0: RX =
ProbeReq SA=3D830be04a DA=3D830be044=0A> BSSID=3D830be050 (tx_last_beacon=
=3D1)=0A> > wlan0: RX ProbeReq SA=3D8311004a DA=3D83110044=0A> BSSID=3D8311=
0050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8312c04a DA=3D8312c=
044=0A> BSSID=3D8312c050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=
=3D8312e04a DA=3D8312e044=0A> BSSID=3D8312e050 (tx_last_beacon=3D1)=0A> > w=
lan0: RX ProbeReq SA=3D8313a04a DA=3D8313a044=0A> BSSID=3D8313a050 (tx_last=
_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D830e604a DA=3D830e6044=0A> BSSID=
=3D830e6050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8313604a DA=
=3D83136044=0A> BSSID=3D83136050 (tx_last_beacon=3D1)=0A> > wlan0: Sending =
ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq SA=3D831d004a DA=3D831d0044=
=0A> BSSID=3D831d0050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D83=
1d604a DA=3D831d6044=0A> BSSID=3D831d6050 (tx_last_beacon=3D1)=0A> > wlan0:=
 Sending ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq SA=3D8329004a DA=3D=
83290044=0A> BSSID=3D83290050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq=
 SA=3D831d204a DA=3D831d2044=0A> BSSID=3D831d2050 (tx_last_beacon=3D1)=0A> =
> wlan0: Sending ProbeResp to 838e1804=0A> > wlan0: RX ProbeReq SA=3D833200=
4a DA=3D83320044=0A> BSSID=3D83320050 (tx_last_beacon=3D1)=0A> > wlan0: Sen=
ding ProbeResp to 838e1804=0A> > wlan0: RX ProbeReq SA=3D8332c04a DA=3D8332=
c044=0A> BSSID=3D8332c050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeRe=
sp to 838e1604=0A> > wlan0: RX ProbeReq SA=3D8333e04a DA=3D8333e044=0A> BSS=
ID=3D8333e050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e16=
04=0A> > wlan0: RX ProbeReq SA=3D8333c04a DA=3D8333c044=0A> BSSID=3D8333c05=
0 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1a04=0A> > wla=
n0: RX ProbeReq SA=3D832e804a DA=3D832e8044=0A> BSSID=3D832e8050 (tx_last_b=
eacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1a04=0A> > wlan0: RX Probe=
Req SA=3D8333a04a DA=3D8333a044=0A> BSSID=3D8333a050 (tx_last_beacon=3D1)=
=0A> > wlan0: Sending ProbeResp to 838e1a04=0A> > wlan0: RX ProbeReq SA=3D8=
334a04a DA=3D8334a044=0A> BSSID=3D8334a050 (tx_last_beacon=3D1)=0A> > wlan0=
: RX ProbeReq SA=3D8335204a DA=3D83352044=0A> BSSID=3D83352050 (tx_last_bea=
con=3D1)=0A> > wlan0: Sending ProbeResp to 838e1804=0A> > wlan0: RX ProbeRe=
q SA=3D8331204a DA=3D83312044=0A> BSSID=3D83312050 (tx_last_beacon=3D1)=0A>=
 > wlan0: RX ProbeReq SA=3D833b804a DA=3D833b8044=0A> BSSID=3D833b8050 (tx_=
last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1a04=0A> > wlan0: RX=
 ProbeReq SA=3D8303e04a DA=3D8303e044=0A> BSSID=3D8303e050 (tx_last_beacon=
=3D1)=0A> > wlan0: Sending ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq S=
A=3D8308404a DA=3D83084044=0A> BSSID=3D83084050 (tx_last_beacon=3D1)=0A> > =
wlan0: RX ProbeReq SA=3D8307204a DA=3D83072044=0A> BSSID=3D83072050 (tx_las=
t_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8311604a DA=3D83116044=0A> BSSI=
D=3D83116050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8311204a DA=
=3D83112044=0A> BSSID=3D83112050 (tx_last_beacon=3D1)=0A> > wlan0: Sending =
ProbeResp to 838e1804=0A> > wlan0: RX ProbeReq SA=3D831ca04a DA=3D831ca044=
=0A> BSSID=3D831ca050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D83=
1c804a DA=3D831c8044=0A> BSSID=3D831c8050 (tx_last_beacon=3D1)=0A> > wlan0:=
 Sending ProbeResp to 838e1a04=0A> > wlan0: RX ProbeReq SA=3D8319c04a DA=3D=
8319c044=0A> BSSID=3D8319c050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq=
 SA=3D831ce04a DA=3D831ce044=0A> BSSID=3D831ce050 (tx_last_beacon=3D1)=0A> =
> wlan0: Sending ProbeResp to 838e1804=0A> > wlan0: RX ProbeReq SA=3D831e20=
4a DA=3D831e2044=0A> BSSID=3D831e2050 (tx_last_beacon=3D1)=0A> > wlan0: RX =
ProbeReq SA=3D831a204a DA=3D831a2044=0A> BSSID=3D831a2050 (tx_last_beacon=
=3D1)=0A> > wlan0: Sending ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq S=
A=3D832c604a DA=3D832c6044=0A> BSSID=3D832c6050 (tx_last_beacon=3D1)=0A> > =
wlan0: RX ProbeReq SA=3D832cc04a DA=3D832cc044=0A> BSSID=3D832cc050 (tx_las=
t_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D832d404a DA=3D832d4044=0A> BSSI=
D=3D832d4050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8301e04a DA=
=3D8301e044=0A> BSSID=3D8301e050 (tx_last_beacon=3D1)=0A> > wlan0: RX Probe=
Req SA=3D8338004a DA=3D83380044=0A> BSSID=3D83380050 (tx_last_beacon=3D1)=
=0A> > wlan0: RX ProbeReq SA=3D832b204a DA=3D832b2044=0A> BSSID=3D832b2050 =
(tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1a04=0A> > wlan0=
: RX ProbeReq SA=3D8303a04a DA=3D8303a044=0A> BSSID=3D8303a050 (tx_last_bea=
con=3D1)=0A> > wlan0: RX ProbeReq SA=3D831e804a DA=3D831e8044=0A> BSSID=3D8=
31e8050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1204=0A>=
 > wlan0: RX ProbeReq SA=3D8311c04a DA=3D8311c044=0A> BSSID=3D8311c050 (tx_=
last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8312004a DA=3D83120044=0A> B=
SSID=3D83120050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e=
1004=0A> > wlan0: RX ProbeReq SA=3D8312a04a DA=3D8312a044=0A> BSSID=3D8312a=
050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8317c04a DA=3D8317c0=
44=0A> BSSID=3D8317c050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp=
 to 838e1a04=0A> > wlan0: RX ProbeReq SA=3D8311e04a DA=3D8311e044=0A> BSSID=
=3D8311e050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8321404a DA=
=3D83214044=0A> BSSID=3D83214050 (tx_last_beacon=3D1)=0A> > wlan0: RX Probe=
Req SA=3D831c804a DA=3D831c8044=0A> BSSID=3D831c8050 (tx_last_beacon=3D1)=
=0A> > wlan0: Sending ProbeResp to 838e1604=0A> > wlan0: RX ProbeReq SA=3D8=
32d404a DA=3D832d4044=0A> BSSID=3D832d4050 (tx_last_beacon=3D1)=0A> > wlan0=
: RX ProbeReq SA=3D8301e04a DA=3D8301e044=0A> BSSID=3D8301e050 (tx_last_bea=
con=3D1)=0A> > wlan0: Sending ProbeResp to 838e1004=0A> > wlan0: RX ProbeRe=
q SA=3D83aac04a DA=3D83aac044=0A> BSSID=3D83aac050 (tx_last_beacon=3D1)=0A>=
 > wlan0: RX ProbeReq SA=3D8334204a DA=3D83342044=0A> BSSID=3D83342050 (tx_=
last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1a04=0A> > wlan0: RX=
 ProbeReq SA=3D832f604a DA=3D832f6044=0A> BSSID=3D832f6050 (tx_last_beacon=
=3D1)=0A> > wlan0: RX ProbeReq SA=3D832de04a DA=3D832de044=0A> BSSID=3D832d=
e050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D83a0e04a DA=3D83a0e=
044=0A> BSSID=3D83a0e050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=
=3D8303404a DA=3D83034044=0A> BSSID=3D83034050 (tx_last_beacon=3D1)=0A> > w=
lan0: RX ProbeReq SA=3D8325404a DA=3D83254044=0A> BSSID=3D83254050 (tx_last=
_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8306c04a DA=3D8306c044=0A> BSSID=
=3D8306c050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8304604a DA=
=3D83046044=0A> BSSID=3D83046050 (tx_last_beacon=3D1)=0A> > wlan0: Sending =
ProbeResp to 838e1004=0A> > wlan0: RX ProbeReq SA=3D8307804a DA=3D83078044=
=0A> BSSID=3D83078050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D83=
35a04a DA=3D8335a044=0A> BSSID=3D8335a050 (tx_last_beacon=3D1)=0A> > wlan0:=
 RX ProbeReq SA=3D8312c04a DA=3D8312c044=0A> BSSID=3D8312c050 (tx_last_beac=
on=3D1)=0A> > wlan0: RX ProbeReq SA=3D8312e04a DA=3D8312e044=0A> BSSID=3D83=
12e050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1804=0A> =
> wlan0: RX ProbeReq SA=3D8313804a DA=3D83138044=0A> BSSID=3D83138050 (tx_l=
ast_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1a04=0A> > wlan0: RX =
ProbeReq SA=3D8312204a DA=3D83122044=0A> BSSID=3D83122050 (tx_last_beacon=
=3D1)=0A> > wlan0: RX ProbeReq SA=3D831e404a DA=3D831e4044=0A> BSSID=3D831e=
4050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1804=0A> > =
wlan0: RX ProbeReq SA=3D8314e04a DA=3D8314e044=0A> BSSID=3D8314e050 (tx_las=
t_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1204=0A> > wlan0: RX Pr=
obeReq SA=3D831fa04a DA=3D831fa044=0A> BSSID=3D831fa050 (tx_last_beacon=3D1=
)=0A> > wlan0: Sending ProbeResp to 838e1804=0A> > wlan0: RX ProbeReq SA=3D=
8320804a DA=3D83208044=0A> BSSID=3D83208050 (tx_last_beacon=3D1)=0A> > wlan=
0: Sending ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq SA=3D8321a04a DA=
=3D8321a044=0A> BSSID=3D8321a050 (tx_last_beacon=3D1)=0A> > wlan0: Sending =
ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq SA=3D8321004a DA=3D83210044=
=0A> BSSID=3D83210050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp t=
o 838e1204=0A> > wlan0: RX ProbeReq SA=3D8321204a DA=3D83212044=0A> BSSID=
=3D83212050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1204=
=0A> > wlan0: RX ProbeReq SA=3D8324a04a DA=3D8324a044=0A> BSSID=3D8324a050 =
(tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8325c04a DA=3D8325c044=
=0A> BSSID=3D8325c050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp t=
o 838e1a04=0A> > wlan0: RX ProbeReq SA=3D8328604a DA=3D83286044=0A> BSSID=
=3D83286050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D832f004a DA=
=3D832f0044=0A> BSSID=3D832f0050 (tx_last_beacon=3D1)=0A> > wlan0: Sending =
ProbeResp to 838e1a04=0A> > wlan0: RX ProbeReq SA=3D8322604a DA=3D83226044=
=0A> BSSID=3D83226050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D83=
26204a DA=3D83262044=0A> BSSID=3D83262050 (tx_last_beacon=3D1)=0A> > wlan0:=
 RX ProbeReq SA=3D8331e04a DA=3D8331e044=0A> BSSID=3D8331e050 (tx_last_beac=
on=3D1)=0A> > wlan0: RX ProbeReq SA=3D832d204a DA=3D832d2044=0A> BSSID=3D83=
2d2050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8335c04a DA=3D833=
5c044=0A> BSSID=3D8335c050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeR=
esp to 838e1804=0A> > wlan0: RX ProbeReq SA=3D83aa404a DA=3D83aa4044=0A> BS=
SID=3D83aa4050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D83b2a04a =
DA=3D83b2a044=0A> BSSID=3D83b2a050 (tx_last_beacon=3D1)=0A> > wlan0: Sendin=
g ProbeResp to 838e1804=0A> > wlan0: RX ProbeReq SA=3D832fa04a DA=3D832fa04=
4=0A> BSSID=3D832fa050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8=
309404a DA=3D83094044=0A> BSSID=3D83094050 (tx_last_beacon=3D1)=0A> > wlan0=
: Sending ProbeResp to 838e1804=0A> > wlan0: RX ProbeReq SA=3D830e804a DA=
=3D830e8044=0A> BSSID=3D830e8050 (tx_last_beacon=3D1)=0A> > wlan0: RX Probe=
Req SA=3D8313c04a DA=3D8313c044=0A> BSSID=3D8313c050 (tx_last_beacon=3D1)=
=0A> > wlan0: RX ProbeReq SA=3D8314c04a DA=3D8314c044=0A> BSSID=3D8314c050 =
(tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8315404a DA=3D83154044=
=0A> BSSID=3D83154050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D83=
16004a DA=3D83160044=0A> BSSID=3D83160050 (tx_last_beacon=3D1)=0A> > wlan0:=
 RX ProbeReq SA=3D8310a04a DA=3D8310a044=0A> BSSID=3D8310a050 (tx_last_beac=
on=3D1)=0A> > wlan0: Sending ProbeResp to 838e1004=0A> > wlan0: RX ProbeReq=
 SA=3D830fc04a DA=3D830fc044=0A> BSSID=3D830fc050 (tx_last_beacon=3D1)=0A> =
> wlan0: RX ProbeReq SA=3D831a804a DA=3D831a8044=0A> BSSID=3D831a8050 (tx_l=
ast_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1804=0A> > wlan0: RX =
ProbeReq SA=3D832c804a DA=3D832c8044=0A> BSSID=3D832c8050 (tx_last_beacon=
=3D1)=0A> > wlan0: RX ProbeReq SA=3D831c404a DA=3D831c4044=0A> BSSID=3D831c=
4050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1004=0A> > =
wlan0: RX ProbeReq SA=3D8336c04a DA=3D8336c044=0A> BSSID=3D8336c050 (tx_las=
t_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8336e04a DA=3D8336e044=0A> BSSI=
D=3D8336e050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e100=
4=0A> > wlan0: RX ProbeReq SA=3D83ac604a DA=3D83ac6044=0A> BSSID=3D83ac6050=
 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D83b6c04a DA=3D83b6c044=
=0A> BSSID=3D83b6c050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp t=
o 838e1a04=0A> > wlan0: RX ProbeReq SA=3D8337a04a DA=3D8337a044=0A> BSSID=
=3D8337a050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8305c04a DA=
=3D8305c044=0A> BSSID=3D8305c050 (tx_last_beacon=3D1)=0A> > wlan0: Sending =
ProbeResp to 838e1604=0A> > wlan0: RX ProbeReq SA=3D8309e04a DA=3D8309e044=
=0A> BSSID=3D8309e050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D83=
0b004a DA=3D830b0044=0A> BSSID=3D830b0050 (tx_last_beacon=3D1)=0A> > wlan0:=
 Sending ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq SA=3D831ec04a DA=3D=
831ec044=0A> BSSID=3D831ec050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq=
 SA=3D8310604a DA=3D83106044=0A> BSSID=3D83106050 (tx_last_beacon=3D1)=0A> =
> wlan0: Sending ProbeResp to 838e1604=0A> > phy0: Adding new IBSS station =
8324e04a (dev=3Dwlan0)=0A> > phy0: Allocated STA 830c8224=0A> > phy0: Inser=
ted STA 830c8224=0A> > wlan0: RX ProbeReq SA=3D832aa04a DA=3D832aa044=0A> B=
SSID=3D832aa050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D832ae04a=
 DA=3D832ae044=0A> BSSID=3D832ae050 (tx_last_beacon=3D1)=0A> > wlan0: Sendi=
ng ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq SA=3D8323004a DA=3D832300=
44=0A> BSSID=3D83230050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D=
832e004a DA=3D832e0044=0A> BSSID=3D832e0050 (tx_last_beacon=3D1)=0A> > wlan=
0: RX ProbeReq SA=3D8323804a DA=3D83238044=0A> BSSID=3D83238050 (tx_last_be=
acon=3D1)=0A> > wlan0: RX ProbeReq SA=3D832d804a DA=3D832d8044=0A> BSSID=3D=
832d8050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8330e04a DA=3D8=
330e044=0A> BSSID=3D8330e050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq =
SA=3D8331c04a DA=3D8331c044=0A> BSSID=3D8331c050 (tx_last_beacon=3D1)=0A> >=
 wlan0: Sending ProbeResp to 838e1004=0A> > wlan0: RX ProbeReq SA=3D8334204=
a DA=3D83342044=0A> BSSID=3D83342050 (tx_last_beacon=3D1)=0A> > wlan0: RX P=
robeReq SA=3D8397004a DA=3D83970044=0A> BSSID=3D83970050 (tx_last_beacon=3D=
1)=0A> > wlan0: Sending ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq SA=
=3D830ba04a DA=3D830ba044=0A> BSSID=3D830ba050 (tx_last_beacon=3D1)=0A> > w=
lan0: RX ProbeReq SA=3D830bc04a DA=3D830bc044=0A> BSSID=3D830bc050 (tx_last=
_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1a04=0A> > wlan0: RX Pro=
beReq SA=3D830f804a DA=3D830f8044=0A> BSSID=3D830f8050 (tx_last_beacon=3D1)=
=0A> > wlan0: Sending ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq SA=3D8=
309004a DA=3D83090044=0A> BSSID=3D83090050 (tx_last_beacon=3D1)=0A> > wlan0=
: Sending ProbeResp to 838e1804=0A> > wlan0: RX ProbeReq SA=3D8310204a DA=
=3D83102044=0A> BSSID=3D83102050 (tx_last_beacon=3D1)=0A> > wlan0: Sending =
ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq SA=3D832ea04a DA=3D832ea044=
=0A> BSSID=3D832ea050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp t=
o 838e1a04=0A> > wlan0: RX ProbeReq SA=3D8311404a DA=3D83114044=0A> BSSID=
=3D83114050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1a04=
=0A> > wlan0: RX ProbeReq SA=3D8310804a DA=3D83108044=0A> BSSID=3D83108050 =
(tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1804=0A> > wlan0=
: RX ProbeReq SA=3D831b804a DA=3D831b8044=0A> BSSID=3D831b8050 (tx_last_bea=
con=3D1)=0A> > wlan0: RX ProbeReq SA=3D831ba04a DA=3D831ba044=0A> BSSID=3D8=
31ba050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1204=0A>=
 > wlan0: RX ProbeReq SA=3D8310e04a DA=3D8310e044=0A> BSSID=3D8310e050 (tx_=
last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D830e604a DA=3D830e6044=0A> B=
SSID=3D830e6050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D831d804a=
 DA=3D831d8044=0A> BSSID=3D831d8050 (tx_last_beacon=3D1)=0A> > wlan0: RX Pr=
obeReq SA=3D831e404a DA=3D831e4044=0A> BSSID=3D831e4050 (tx_last_beacon=3D1=
)=0A> > wlan0: RX ProbeReq SA=3D831ee04a DA=3D831ee044=0A> BSSID=3D831ee050=
 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8310604a DA=3D83106044=
=0A> BSSID=3D83106050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D83=
22804a DA=3D83228044=0A> BSSID=3D83228050 (tx_last_beacon=3D1)=0A> > wlan0:=
 RX ProbeReq SA=3D8322a04a DA=3D8322a044=0A> BSSID=3D8322a050 (tx_last_beac=
on=3D1)=0A> > wlan0: Sending ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq=
 SA=3D8303204a DA=3D83032044=0A> BSSID=3D83032050 (tx_last_beacon=3D1)=0A> =
> wlan0: RX ProbeReq SA=3D832e004a DA=3D832e0044=0A> BSSID=3D832e0050 (tx_l=
ast_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1204=0A> > wlan0: RX =
ProbeReq SA=3D83b6c04a DA=3D83b6c044=0A> BSSID=3D83b6c050 (tx_last_beacon=
=3D1)=0A> > wlan0: RX ProbeReq SA=3D8334204a DA=3D83342044=0A> BSSID=3D8334=
2050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1804=0A> > =
wlan0: RX ProbeReq SA=3D839ae04a DA=3D839ae044=0A> BSSID=3D839ae050 (tx_las=
t_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D830c004a DA=3D830c0044=0A> BSSI=
D=3D830c0050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1a0=
4=0A> > wlan0: RX ProbeReq SA=3D8309204a DA=3D83092044=0A> BSSID=3D83092050=
 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D831e404a DA=3D831e4044=
=0A> BSSID=3D831e4050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D83=
1ee04a DA=3D831ee044=0A> BSSID=3D831ee050 (tx_last_beacon=3D1)=0A> > wlan0:=
 Sending ProbeResp to 838e1204=0A> > wlan0: RX ProbeReq SA=3D832d804a DA=3D=
832d8044=0A> BSSID=3D832d8050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq=
 SA=3D8326804a DA=3D83268044=0A> BSSID=3D83268050 (tx_last_beacon=3D1)=0A> =
> wlan0: Sending ProbeResp to 838e1004=0A> > wlan0: RX ProbeReq SA=3D832fe0=
4a DA=3D832fe044=0A> BSSID=3D832fe050 (tx_last_beacon=3D1)=0A> > wlan0: RX =
ProbeReq SA=3D8330204a DA=3D83302044=0A> BSSID=3D83302050 (tx_last_beacon=
=3D1)=0A> > wlan0: RX ProbeReq SA=3D8324204a DA=3D83242044=0A> BSSID=3D8324=
2050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8332a04a DA=3D8332a=
044=0A> BSSID=3D8332a050 (tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=
=3D832ca04a DA=3D832ca044=0A> BSSID=3D832ca050 (tx_last_beacon=3D1)=0A> > w=
lan0: RX ProbeReq SA=3D83b9804a DA=3D83b98044=0A> BSSID=3D83b98050 (tx_last=
_beacon=3D1)=0A> > wlan0: Sending ProbeResp to 838e1604=0A> > wlan0: RX Pro=
beReq SA=3D8305804a DA=3D83058044=0A> BSSID=3D83058050 (tx_last_beacon=3D1)=
=0A> > wlan0: RX ProbeReq SA=3D8311004a DA=3D83110044=0A> BSSID=3D83110050 =
(tx_last_beacon=3D1)=0A> > wlan0: RX ProbeReq SA=3D8303a04a DA=3D8303a044=
=0A> BSSID=3D8303a050 (tx_last_beacon=3D1)=0A> > wlan0: Sending ProbeResp t=
o 838e1604=0A> > root@OpenWrt:/# =0A> >=A0 CTRL-A Z for help |115200 8N1 | =
NOR | Minicom=0A> 2.3-rc | VT102 |=A0 =A0 =A0 Offline=0A> > =0A> > ________=
_______________________________________=0A> > B.A.T.M.A.N mailing list=0A> =
> B.A.T.M.A.N@lists.open-mesh.net=0A> > https://lists.open-mesh.net/mm/list=
info/b.a.t.m.a.n=0A> =0A> 
