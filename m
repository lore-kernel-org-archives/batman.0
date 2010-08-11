Return-Path: <djb31st@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTinhcpamuMGApH9D5SPn3VNkEi9BDCYwGkRcDdJq@mail.gmail.com>
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTim-RfupM1iHH-dFwtDiN5RLFVaP=AWK9=MH-dGK@mail.gmail.com>
	<AANLkTik1UtAUDEU=zcyYzAzhVENQ_+XF7YhvWp+hWk=n@mail.gmail.com>
	<AANLkTinhcpamuMGApH9D5SPn3VNkEi9BDCYwGkRcDdJq@mail.gmail.com>
Date: Wed, 11 Aug 2010 15:50:38 +0300
Message-ID: <AANLkTi==R4oWr_zTLapUxCddFkjyD5LeV61nzEqKi+Us@mail.gmail.com>
From: David Beaumont <djb31st@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Nat Question
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hmm i was hoping it would be that simple.. but alas it wasn't.

Here is the output from tcpdump on the bat0 interface

tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on bat0, link-type EN10MB (Ethernet), capture size 96 bytes
14:19:43.356750 IP 192.168.1.189.52560 > fx-in-f99.1e100.net.80: SWE 424611=
5553:
4246115553(0) win 5840 <mss 1460,nop,nop,sackOK,nop,wscale 4>
14:19:43.464324 IP fx-in-f99.1e100.net.80 > 192.168.1.189.52560: S 16938928=
36:16
93892836(0) ack 4246115554 win 5720 <mss 1430,nop,nop,sackOK,nop,wscale 6>
14:19:43.467474 IP 192.168.1.189.52560 > fx-in-f99.1e100.net.80: . ack 1 wi=
n 365

14:19:43.467776 IP 192.168.1.189.52560 > fx-in-f99.1e100.net.80: P 1:78(77)=
 ack
1 win 365
14:19:45.737534 IP 192.168.1.189.58552 > fx-in-f147.1e100.net.80: P 3961995=
538:3
961995615(77) ack 1025796129 win 365
14:19:46.467535 IP 192.168.1.189.52560 > fx-in-f99.1e100.net.80: P 1:78(77)=
 ack
1 win 365

and my network interfaces are configured as follows

ath0      Link encap:Ethernet  HWaddr 00:0C:42:3A:75:A2
         inet addr:100.10.17.3  Bcast:100.255.255.255  Mask:255.0.0.0
         UP BROADCAST RUNNING MULTICAST  MTU:1524  Metric:1
         RX packets:894 errors:0 dropped:68 overruns:0 frame:0
         TX packets:362 errors:0 dropped:0 overruns:0 carrier:0
         collisions:0 txqueuelen:0
         RX bytes:55386 (54.0 KiB)  TX bytes:20256 (19.7 KiB)

bat0      Link encap:Ethernet  HWaddr 00:FF:D0:24:1D:30
         inet addr:10.0.1.1  Bcast:10.0.1.255  Mask:255.255.255.0
         UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
         RX packets:52 errors:0 dropped:0 overruns:0 frame:0
         TX packets:35 errors:0 dropped:1 overruns:0 carrier:0
         collisions:0 txqueuelen:1000
         RX bytes:5461 (5.3 KiB)  TX bytes:3942 (3.8 KiB)

br-lan    Link encap:Ethernet  HWaddr 00:0D:B9:19:0E:98
         inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
         UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
         RX packets:52 errors:0 dropped:0 overruns:0 frame:0
         TX packets:36 errors:0 dropped:0 overruns:0 carrier:0
         collisions:0 txqueuelen:0
         RX bytes:4733 (4.6 KiB)  TX bytes:4344 (4.2 KiB)

Can still ping, and also resolve DNS but no traffic on TCP or UDP will send

On Wed, Aug 11, 2010 at 3:28 PM, Outback Dingo <outbackdingo@gmail.com> wro=
te:
> or its a basic MTU problem, might want to try searching google for openwr=
t
> batman MTU issues
>
> On Wed, Aug 11, 2010 at 7:48 AM, David Beaumont <djb31st@gmail.com> wrote=
:
>>
>> I have a B.A.T.M.A.N mesh successfully=A0configured=A0on x86 hardware.
>>
>> I can currently ping the internet from the router that is connected
>> via the mesh, however i can't download or connect to any webpages.
>>
>> I see the request for the page going over the bat0 interface and being
>> received=A0at the other end.
>>
>> I've a feeling this is a basic nat problem, but have been unable to
>> find a solution.
>>
>> I am using OpenWRT software.
>>
>> Any advice? or hints?
>>
>> Thanks
>
>
