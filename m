Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7FB45.27570B4D"
Date: Wed, 19 Sep 2007 22:14:43 -0700
Message-ID: <840E3F681DF3D043B353C0FDD4A6C35310810F@ex9.hostedexchange.local>
References: <2bda28cd0709190519r74f0c58ncc1c23553c925091@mail.gmail.com><200709191525.12422.onelektra@gmx.net><17196.85.41.146.90.1190212517.squirrel@krisma.oltrelinux.com><200709191907.41922.onelektra@gmx.net>
	<19910.85.41.146.90.1190236360.squirrel@krisma.oltrelinux.com>
From: "Michael Burmeister-Brown" <mike@netequality.org>
Subject: [B.A.T.M.A.N.] 919 build
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7FB45.27570B4D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Antonio,

I am continuing to have problems sshing into nodes.  Currently, it is a =
repeater.  Doing ifconfig eth1 (my wireless adapter) gives me this:

eth1      Link encap:Ethernet  HWaddr 00:19:D2:03:D2:00 =20
          inet addr:10.19.66.100  Bcast:10.19.66.127  =
Mask:255.255.255.128


I am associated with the public AP.

So I then do:

ssh 10.19.66.1 -l root
ssh: connect to host 10.19.66.1 port 22: No route to host

I never had problems to ssh into gateways or repeaters before.

What is wrong?  This really worked in prior builds...

Mike





-----Original Message-----
From: b.a.t.m.a.n-bounces@open-mesh.net on behalf of =
a.anselmi@oltrelinux.com
Sent: Wed 9/19/2007 2:12 PM
To: The list for a Better Approach To Mobile Ad-hoc Networking
Subject: Re: [B.A.T.M.A.N.] batman routing clarification
=20
Thank for reply
I just read it but maybe is late in the night or maybe I'm too tired...
but some statements are puzzling me. Sure tomorrow morning I'll have  a
more clean mind and take a look more deeper to your scripts.

ciao

Antonio


>> What above is well right using that bandwidht values (6Mb) but with
>> poor/lossy links we have also to consider the IP datagrams loss at
>> network
>> layer ---> which will cause TCP retransmits at higher layers (think =
to
>> http connection) just based on that links.
>> For this reason maybe a kind of "bandwidth threshold" can help in
>> preferring a 500_Kb per link mulit-hop path rather than a 300_Kb link
>> direct path.
>
> Well, you certainly have a point here. The goal of a routing protocol
> should
> be to achive the maximum achievable bandwidth for all nodes using the
> network. There is a fancy word for this condition that one can use to =
brag
> around and sound like a scientist: equilibrium.
>
> A route can consist of a large number of very good links - this would =
be
> one
> extreme. Or consist of a minimum of lousy links with maximum packet =
loss.
> The first option would consume a very high amount of available =
bandwidth
> since
> there will be many retransimissions disturbing others and it is likely =
to
> be
> relatively slow if your machines use one wireless interface only. The
> latter
> is likely to be completely unusable for anything more than transfering =
a
> few
> bytes.
>
> The protocol should find the most effective compromise, of course.
>
> With OLSR and ETX a two hop route with ETX=3D1,1 on each link won't be =
used
> if
> there is a direct link with ETX=3D2,1. The idea of ETX is to find the =
best
> compromise regarding loss and retransmissions. One has to note that =
this
> approach is only useful for wireless networks. ETX on wired =
connections
> sucks.
>
> We are doing basically the same with Batman, but it is inherit in the
> algorithm. Usually a shorter route has a smaller propagation delay - =
so
> packets are approaching faster at the node that is counting. Only if =
the
> longer - and slower - route looses significant less packets Batman =
will
> choose the longer path. Batman has a small benefit on wired =
connections
> because they are usually much faster than wireless links and thus tend =
to
> be
> preferred.
>
> In the previous example OLSR will prefer a single hop route with more =
than
> 50%
> packetloss, rather than the two-hop path with approx. 17% packetloss.
>
> There are some people suggesting that Batman preferres shorter routes =
too
> much, so it is interesting to collect such reports. But =
misconfigurations
> have to be ruled out when collecting such data.
>
> Something that could help to improve the situation as a workaround in =
this
> case is to increase the broadcast rate in the wireless settings of the
> cards.
> This will reduce the range of broadcasts and can improve the result,
> because
> the number of OGMs on stretched links will decrease.
>
> cu elektra
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


_______________________________________________
B.A.T.M.A.N mailing list
B.A.T.M.A.N@open-mesh.net
https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


------_=_NextPart_001_01C7FB45.27570B4D
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IiwFAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEACgAAADkxOSBidWlsZADTAgEFgAMA
DgAAANcHCQATABYADgArAAMATAEBIIADAA4AAADXBwkAEwAWAA4AKwADAEwBAQmAAQAhAAAAREMx
OEUwQTI1NEM5MzU0MTg1MEE0REZBOTU2ODZBMzkAJgcBA5AGAHQTAAA5AAAAAwAmAAAAAAADADYA
AAAAAEAAOQBNC1cnRfvHAR4APQABAAAAAQAAAAAAAAACAUcAAQAAADYAAABjPVVTO2E9IDtwPUZp
cnN0IE9yZ2FuaXphdGk7bD1FWDktMDcwOTIwMDUxNDQzWi0xNzE2OAAAAB4ASQABAAAAMAAAAFJl
OiBbQi5BLlQuTS5BLk4uXSBiYXRtYW4gcm91dGluZyBjbGFyaWZpY2F0aW9uAEAATgAAFJzPAfvH
AR4AWgABAAAAIgAAAGIuYS50Lm0uYS5uLWJvdW5jZXNAb3Blbi1tZXNoLm5ldAAAAAIBWwABAAAA
YQAAAAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAAAGIuYS50Lm0uYS5uLWJvdW5jZXNAb3Blbi1tZXNo
Lm5ldABTTVRQAGIuYS50Lm0uYS5uLWJvdW5jZXNAb3Blbi1tZXNoLm5ldAAAAAACAVwAAQAAACcA
AABTTVRQOkIuQS5ULk0uQS5OLUJPVU5DRVNAT1BFTi1NRVNILk5FVAAAHgBdAAEAAAAZAAAAYS5h
bnNlbG1pQG9sdHJlbGludXguY29tAAAAAAIBXgABAAAATwAAAAAAAACBKx+kvqMQGZ1uAN0BD1QC
AAAAAGEuYW5zZWxtaUBvbHRyZWxpbnV4LmNvbQBTTVRQAGEuYW5zZWxtaUBvbHRyZWxpbnV4LmNv
bQAAAgFfAAEAAAAeAAAAU01UUDpBLkFOU0VMTUlAT0xUUkVMSU5VWC5DT00AAAAeAGYAAQAAAAUA
AABTTVRQAAAAAB4AZwABAAAAIgAAAGIuYS50Lm0uYS5uLWJvdW5jZXNAb3Blbi1tZXNoLm5ldAAA
AB4AaAABAAAABQAAAFNNVFAAAAAAHgBpAAEAAAAZAAAAYS5hbnNlbG1pQG9sdHJlbGludXguY29t
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
mHX/XEPTaC3BW6MU0iigfjKPNPuXsFIwZC3ChPJcJyTnTKD/UaAe8T5h6DvbUM/wpnpA0v92ol5B
EbCPNHexnhFMMRnXn7AkgQIVCoBx1VB0LPJt46xpnjlPR03Uol+Bd4F/kCAyIaSmYtHi4Bkk2U5j
24lQtVFrd6GIVl8pHyov/yr6iFZVeVtRmtHQIlDhLA+PVgBKrA7XeoFzOi9wEMVQ4S5Kuy9tbTED
gZD9USAvSXnZWzsqKv82Tys//17gLI8tmy6PL5wwnzGvMr8FQ+l9QFAeADUQAQAAAEIAAAA8ODQw
RTNGNjgxREYzRDA0M0IzNTNDMEZERDRBNkMzNTMxMDgxMEZAZXg5Lmhvc3RlZGV4Y2hhbmdlLmxv
Y2FsPgAAAB4AORABAAAABgEAADwyYmRhMjhjZDA3MDkxOTA1MTlyNzRmMGM1OG5jYzFjMjM1NTNj
OTI1MDkxQG1haWwuZ21haWwuY29tPjwyMDA3MDkxOTE1MjUuMTI0MjIub25lbGVrdHJhQGdteC5u
ZXQ+PDE3MTk2Ljg1LjQxLjE0Ni45MC4xMTkwMjEyNTE3LnNxdWlycmVsQGtyaXNtYS5vbHRyZWxp
bnV4LmNvbT48MjAwNzA5MTkxOTA3LjQxOTIyLm9uZWxla3RyYUBnbXgubmV0PiA8MTk5MTAuODUu
NDEuMTQ2LjkwLjExOTAyMzYzNjAuc3F1aXJyZWxAa3Jpc21hLm9sdHJlbGludXguY29tPgAAAB4A
RxABAAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A8xABAAAAHAAAADkAMQA5ACAAYgB1
AGkAbABkAC4ARQBNAEwAAAALAPYQAAAAAEAABzDKCddDRPvHAUAACDD3z1snRfvHAQMA3j+vbwAA
AwDxPwkEAAAeAPg/AQAAABkAAABNaWNoYWVsIEJ1cm1laXN0ZXItQnJvd24AAAAAAgH5PwEAAACO
AAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC9PPUZJUlNUIE9SR0FOSVpBVElPTi9PVT1G
SVJTVCBBRE1JTklTVFJBVElWRSBHUk9VUC9DTj1SRUNJUElFTlRTL0NOPU5FVEVRVUFMSVRZLk9S
Ry4uTUlLRV9ORVRFUVVBTElUWS5PUkc0Mjg3NjE2AAAAHgD6PwEAAAAVAAAAU3lzdGVtIEFkbWlu
aXN0cmF0b3IAAAAAAgH7PwEAAAAeAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC4AAAAD
AP0/5AQAAAMAGUAAAAAAAwAaQAAAAAADAB1AAAAAAAMAHkAAAAAAHgAwQAEAAAAtAAAATkVURVFV
QUxJVFkuT1JHLi5NSUtFX05FVEVRVUFMSVRZLk9SRzQyODc2MTYAAAAAHgAxQAEAAAAtAAAATkVU
RVFVQUxJVFkuT1JHLi5NSUtFX05FVEVRVUFMSVRZLk9SRzQyODc2MTYAAAAAHgAyQAEAAAAiAAAA
Yi5hLnQubS5hLm4tYm91bmNlc0BvcGVuLW1lc2gubmV0AAAAHgAzQAEAAAAZAAAAYS5hbnNlbG1p
QG9sdHJlbGludXguY29tAAAAAB4AOEABAAAALQAAAE5FVEVRVUFMSVRZLk9SRy4uTUlLRV9ORVRF
UVVBTElUWS5PUkc0Mjg3NjE2AAAAAB4AOUABAAAAAgAAAC4AAAADAHZA/////wsAKQAAAAAACwAj
AAAAAAADAAYQtpBjTgMABxAEDAAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEFOVE9OSU8s
SUFNQ09OVElOVUlOR1RPSEFWRVBST0JMRU1TU1NISU5HSU5UT05PREVTQ1VSUkVOVExZLElUSVNB
UkVQRUFURVJET0lOR0lGQ09ORklHRVRIMShNWVdJUkVMRVMAAAAAAgF/AAEAAABCAAAAPDg0MEUz
RjY4MURGM0QwNDNCMzUzQzBGREQ0QTZDMzUzMTA4MTBGQGV4OS5ob3N0ZWRleGNoYW5nZS5sb2Nh
bD4AAACSPw==

------_=_NextPart_001_01C7FB45.27570B4D--
