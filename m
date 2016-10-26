Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 26 Oct 2016 10:17:39 +0200
Message-ID: <1499092.KaxnJhUj78@bentobox>
In-Reply-To: <581058E6.4080706@yahoo.com>
References: <580F251E.7060400@yahoo.com> <4752844.Su7blveJaV@bentobox>
 <581058E6.4080706@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1972122.qlm4bq62aN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Whether Batman-adv need suitable wifi network
	card (support interface modes ( mesh point ) ) .
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: johnzeng <johnzeng2013@yahoo.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1972122.qlm4bq62aN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 26. Oktober 2016 15:19:02 CEST johnzeng wrote:
[...] 
> HostB wlan0 : mac addr : ether 00:1d:43:10:15:44
> 
> HostA wlan0 : mac addr: ether c8:3a:35:c9:ce:71
[...]
> i run the command at Host A ( Rt2070 ) at ( ping HostA from HostB)
> iw dev wlan0 station dump:
> Station 00:1d:43:10:15:44 (on wlan0)
[...]

Here we see that host A noticed that there is a different device and
"connected" to it (actually, it just added it as remote station to its
internal list).

This is a good sign - at least when both devices have each other in
their respective station lists (*spoiler* they don't).

> 
> [root@alarmpi ~]# tcpdump -i bat0
> 
> 07:01:40.635517 ARP, Reply 0.0.0.0 is-at 43:05:43:05:00:00 (oui 
> Unknown), length 28
> 07:01:50.655521 ARP, Reply 0.0.0.0 is-at 43:05:43:05:00:00 (oui 
> Unknown), length 28
> 
> [root@alarmpi ~]# tcpdump -i wlan0
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on wlan0, link-type EN10MB (Ethernet), capture size 262144 bytes
> 07:02:35.815528 c8:3a:35:c9:ce:71 (oui Unknown) > Broadcast, ethertype 
> Unknown (0x4305), length 66:
[...]

Here we see an OGM that is transmitted from this device. So for some reason
we don't see the an incoming OGM from host B. Either host B is not really
transmitting it, host A is not receiving it or you just didn't capture long
enough.

[...]
> and i run same command at Host B ( RTL8188CUS ) at ( ping HostB from HostA)
> 
> iw dev wlan0 station dump:
> 
> " is blank "

This means that RTL8188CUS didn't detect a remote IBSS device. This is odd and
at first glance looks to me like a bug in the RTL8188CUS driver. But I would
recommend to get a third (known to work) device and check to which of the
orignal two devices it can connect and which of the other two devices can
connect to it.

You could even use the third device to capture raw wifi frames on a monitor
interface and check if both devices submit these OGMs and if both devices
are beaconing (and reply to probe requests).

But this is basically the main problem here.
The rest of the reply is just to explain some additional things.
---------------------------------------------------------------

[...]
> tcpdump -i wlan0
> 
> 06:57:11.425351 c8:3a:35:c9:ce:71 (oui Unknown) > Broadcast, ethertype 
[...]
> 06:57:11.534759 00:1d:43:10:15:44 (oui Unknown) > Broadcast, ethertype 
[...]

This part shows an OGM from host A and host B. So it can receive OGMs from
other stations and batman-adv is at least trying to send some data. It is
unknown here if the host B is not really sending it or if host A is not
really receiving it.

[...]
> And i thought Rt2070 support Broadcast and RTL8188CUS don't support 
> Broadcast or send ...
> 
> because when i ping ip (RTL8188CUS) from Rt2070 , and i can see ping 
> packet via (tcpdump -i bat0 ) and i can see Rt2070 mac addr via (tcpdump 
> -i wlan0 ) at HOSTB,
> 
> but i ping ip (Rt2070) from RTL8188CUS and i can't see any ping packet 
> from RTL8188CUS and i can't see RTL8188CUS mac via (tcpdump -i wlan0 ) 
> at HOSTA

Both should have working broadcast to get the ARP stuff working for the ping.
But of course this only a good test when each ping tests are done with clean
ARP tables (Linux is sniffing packets to fill its own ARP table without always
sending ARP request). There is a test which you could have done even without
the `iw dev wlan0 station dump` info from above.

This part now is without batman-adv (because the text from you is quite unclear):
--------------------------------------------------------------------------------

But it could be that the ARP table on RTL8188CUS (Host B) was filled by the
ARP request from Host A. And this was to only reason why the ping back from
host B to host A worked.  You can test that by making sure that the ARP table
is clean on both hosts and then start pinging from B to A. Also make some
captures with tcpdump on both hosts that you later can analyze with wireshark.
After your test (when it worked) make sure that the arp table on both hosts
contain entries for each other. And than analyze the dumps for ARP packets in
wireshark to make sure that host B really submitted and request and host A
replied to it.

Kind regards,
	Sven
--nextPart1972122.qlm4bq62aN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYEGajAAoJEF2HCgfBJntGBC8P/3CSZvH1X+FqaWcTMkd7CZfb
gbXiUrjjv+rahvfbq5CSKWgOd3hRZKo7SdKMipGDqQgUsoB+eK0+XM03GtBCmwtr
4i9Qka2yPIjDaRdP0ul7fvxJoIQuKhb/OniUYaKW9OuJq0lCZcfb7Ei16OfXmdj0
6hZEzsGLC9tAACG39qB8vJHiIdiEorgJ2UtsILcjxo9Rfo8TTDsdVT8cwQTAam18
IscDdI/j+AFuOQSgIaPBfb5Onh3iNmgR7wyluMqWYNedxl2ug1cxr2QfwUi7+ln+
Noa9meSg23yC+zmj+gnFBlSGeJQelKP63gedrFpxo/P89YL6X3I4Ps/f2oD10HR5
7T2R0rjIfnUktwczKJkIzGeqmSZfHth+Zh1QP57ap+AYYFiGta9rYpBsC4eICtbG
4FdGm1Qq75MFep9hFRCxuAE4jacPufCi61dEPsJ+StGXQL3kIIAAN0m1jdLh5Vad
RbnoJRpcSgmc4ybjDNK2gVRUORahAsZ5ttHKW/kaQCFvfgvg8iXxieVN4ze+P6gk
CtJRqpuiT4vlA+6qrshdh2UqrcJI6EOvIQmLraYxdFtXj1SX01lkskMAfR7WvK4H
/PHrU50dR/qcfgVUhhVUb/ExkDaYSr8It+EyLaouxehCoo/82jO377qtOAT6PGd4
x9vpYwKvADe9O6tgyiwZ
=lH1o
-----END PGP SIGNATURE-----

--nextPart1972122.qlm4bq62aN--

