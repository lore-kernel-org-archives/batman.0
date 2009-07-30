Return-Path: <Yang.Su@ascom.CH>
In-Reply-To: <200907280020.06026.lindner_marek@yahoo.de>
References: <20090722105639.GH32143@ma.tech.ascom.ch>
	<200907280020.06026.lindner_marek@yahoo.de>
Message-ID: <OF82FBEF87.4CF60579-ONC1257603.002FC1DB-C1257603.004FD789@CHASCOM.INT>
From: Yang Su <Yang.Su@ascom.CH>
Date: Thu, 30 Jul 2009 16:32:04 +0200
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=4EBBFC90DFBC474B8f9e8a93df938690918c4EBBFC90DFBC474B"
Content-Disposition: inline
Subject: Re: [B.A.T.M.A.N.] batman goes looping...
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.net, Andrew Lunn <andrew.lunn@ascom.CH>

--0__=4EBBFC90DFBC474B8f9e8a93df938690918c4EBBFC90DFBC474B
Content-type: text/plain; charset=US-ASCII

-  More information about the UML based test setup: a chain consisting of 9
nodes (each node is an uml instatnce, uml1, uml2 ... uml9). Direct
neighbors (distance=1 hop) can talk to each other with 0% link loss rate.
Nodes that are 2 hop away can talk to each other with 20% link loss rate.
Nodes that are more than 2 hops away cannot communicate to each other. We
shut down the node in the middle (uml5) and measure (with ping) the time it
takes for batman to re-setup the end-to-end routes (from uml1 to uml9).

-  We observe extensive tmp routing loops during the rerouting events. It
often takes batman more than 1 minutes to get any packet through after the
rerouting and it takes even longer (several minutes) before batman
stabilizes.

-  The cause for the loops:

Let's study the interaction between uml1 and uml2:

OGMs from uml9 may arrive at uml1 and uml2 at roughly the same time
(because both of them has a shortest path of 6-hop from uml9).  uml1 and
uml2 will forward those OGMs to each other.  Depending on the timing
relations between uml1 and uml2, there are four possible combinations:

Case 1: first uml1 forwards the OGM received from uml3 to uml2,  then  uml
2 forwards the OGM received from uml3 to uml1.

Case 2: first uml1 forwards the OGM received from uml3 to uml2, then uml 2
forwards the OGM received from uml1 back to uml1.

Case 3: first uml2 forwards the OGM received from uml3 to uml1, then uml1
forwards the OGM received from uml3 to uml2.

Case 4: first uml2 forwards the OGM received from uml3 to uml1, then uml1
forwards the OGM received from uml2 back to uml2.

When the quality of the path from uml1 to uml9 drops down dramatically
(e.g., in our case, path loss rate increases from 0% to 20% after we remove
uml5), 3 out of 4 cases (case 1,2,4) may cause looping between uml1 and
uml2. With the interaction of echo cancellation mechanism, case 2 may even
lead batman into very deep looping.

- To fix the problem:

I explored two ideas:

1.  Similar to what Marek proposed. But push it to the extreme: switch to a
neighbor only when it has the best tq AND it has the newest seqno.  This
fix along seems to already solve the looping problem in the test cases. It
reduces the rerouting time from more than 1 minutes to less than 15
seconds.  Marek: I also tried the patch you sent. It didn't help in this
setup.

2. Relaxed echo cancellation. This is based on  the following observation:
the TQ value that a node puts into OGM is completely decoupled with "from
which neighbor this OGM is received".   As a result, the TQ value contained
in the echoed OGM represent the real TQ value at the neighbor which echoed
this OGM. The current echo cancellation implementation just drops all the
echoed OGM. This may prevent the node from updating the information towards
the neighbor that echos the OGM. In the extreme case, the information
towards that neighbor may becomes completely stale (similar to what happens
in case 2).  The change I  made:  Always check the TQ contained in the
echoed OGMs. When it is worse than the avg TQ towards that neighbor, we use
this TQ reading to update the avg TQ towards that neighbor. This change
didn't show any effect during the chain tests. However, I still include
this change in the patch to bring up the discussion.

In the attachment, I append a patch which contains a preliminary
implementation for both ideas.



Cheers,
Yang
(See attached file: routing-loops.patch)



|------------>
| From:      |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |Marek Lindner <lindner_marek@yahoo.de>                                                                                                            |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
|------------>
| To:        |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |b.a.t.m.a.n@lists.open-mesh.net                                                                                                                   |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
|------------>
| Cc:        |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |Andrew Lunn <andrew.lunn@ascom.ch>, Yang Su <yang.su@ascom.ch>                                                                                    |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
|------------>
| Date:      |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |27.07.2009 18:21                                                                                                                                  |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
|------------>
| Subject:   |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |Re: [B.A.T.M.A.N.] batman goes looping...                                                                                                         |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|






Hi,

> Looking at the logs of uml1, uml1 is always routing to uml9 via uml2.
> The problem here i think is to do with the asymetric links algorithms.
> When sending out an OGM, the node uses the TQ for its best link to the
> originator, not the link the OGM came in on. If the OGM from uml1
> origionally from UML3 reported the TQ via that route, the TQ would
> very likely be lower. uml2 would then not of choosen to swap to
> uml1. However, uml1 reports its best route, which is via uml2. uml2
> does not know this, decides to use uml1, and we have a loop.
>
> Does this all hang together correctly? I'm i interpreting this all
> right...
>
> How would you suggest fix this?

I would tend to say it is a bug in the routing selection code. UML2
switches
the route because it compare thes "negative" TQ message of seqno N with a
TQ
of seqno N - x. I suggest the following fix:

If we receive a TQ value via a neighbor that is smaller than the previous
TQ
that we received via that neighbor we don't change the route to a neighbor
which did not send us the same or newer seqno.

That way your scenario should not happen because uml2 would not switch. On
the
other hand if uml1 really has a better route uml2 would switch as soon as
the
packet with a new seqno via uml1 arrives. What do you think ?

I attached a patch that should do exactly that. As I'm travelling right now

I'm not able to test it before next week. If you find the time to do so,
please
let me know about your findings. This patch is not as strict as it could
be. It
might be necessary to rework it as soon as the concept has been proven.

Thanks again for this thorough analysis. Let us know if you find more.  :-)

Regards,
Marek
--0__=4EBBFC90DFBC474B8f9e8a93df938690918c4EBBFC90DFBC474B
Content-type: application/octet-stream; 
	name="routing-loops.patch"
Content-Disposition: attachment; filename="routing-loops.patch"
Content-transfer-encoding: base64

SW5kZXg6IHR5cGVzLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gdHlwZXMuaAkocmV2aXNpb24gMTM2NSkKKysr
IHR5cGVzLmgJKHdvcmtpbmcgY29weSkKQEAgLTczLDYgKzczLDcgQEAKIAl1aW50OF90IHRxX2lu
ZGV4OwogCXVpbnQ4X3QgdHFfYXZnOwogCXVpbnQ4X3QgbGFzdF90dGw7CisgICAgICAgIHVpbnQx
Nl90IHNlcW5vOyAgICAgICAgIC8qIE1vc3QgcmVjZW50IHNlcW5vIHJlY2VpdmVkIGZyb20gdGhp
cyBuZWlnaGJvciAqLwogCXVuc2lnbmVkIGxvbmcgbGFzdF92YWxpZDsgICAgICAgICAgICAvKiB3
aGVuIGxhc3QgcGFja2V0IHZpYSB0aGlzIG5laWdoYm91ciB3YXMgcmVjZWl2ZWQgKi8KIAlUWVBF
X09GX1dPUkQgcmVhbF9iaXRzW05VTV9XT1JEU107CiAJc3RydWN0IG9yaWdfbm9kZSAqb3JpZ19u
b2RlOwpJbmRleDogcm91dGluZy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHJvdXRpbmcuYwkocmV2aXNpb24g
MTM2NSkKKysrIHJvdXRpbmcuYwkod29ya2luZyBjb3B5KQpAQCAtMzA1LDYgKzMwNSw5IEBACiAJ
b3JpZ19ub2RlLT5mbGFncyA9IGJhdG1hbl9wYWNrZXQtPmZsYWdzOwogCW5laWdoX25vZGUtPmxh
c3RfdmFsaWQgPSBqaWZmaWVzOwogCisgICAgICAgIGlmKGJhdG1hbl9wYWNrZXQtPnNlcW5vID4g
bmVpZ2hfbm9kZS0+c2Vxbm8pCisgICAgICAgICAgICBuZWlnaF9ub2RlLT5zZXFubyA9IGJhdG1h
bl9wYWNrZXQtPnNlcW5vOworICAgICAgICAKIAlyaW5nX2J1ZmZlcl9zZXQobmVpZ2hfbm9kZS0+
dHFfcmVjdiwgJm5laWdoX25vZGUtPnRxX2luZGV4LCBiYXRtYW5fcGFja2V0LT50cSk7CiAJbmVp
Z2hfbm9kZS0+dHFfYXZnID0gcmluZ19idWZmZXJfYXZnKG5laWdoX25vZGUtPnRxX3JlY3YpOwog
CkBAIC0zMjAsMTAgKzMyMywxNiBAQAogCQliZXN0X25laWdoX25vZGUgPSBuZWlnaF9ub2RlOwog
CiAJfQotCi0JdG1wX2huYV9idWZmX2xlbiA9IChobmFfYnVmZl9sZW4gPiBiYXRtYW5fcGFja2V0
LT5udW1faG5hICogRVRIX0FMRU4gPyBiYXRtYW5fcGFja2V0LT5udW1faG5hICogRVRIX0FMRU4g
OiBobmFfYnVmZl9sZW4pOwotCi0JdXBkYXRlX3JvdXRlcyhvcmlnX25vZGUsIGJlc3RfbmVpZ2hf
bm9kZSwgaG5hX2J1ZmYsIHRtcF9obmFfYnVmZl9sZW4pOworICAgICAgICAKKyAgICAgICAgaWYo
YmVzdF9uZWlnaF9ub2RlID09IE5VTEwgfHwgb3JpZ19ub2RlLT5yb3V0ZXIgPT0gTlVMTCl7Cisg
ICAgICAgICAgICAgICAgdG1wX2huYV9idWZmX2xlbiA9IChobmFfYnVmZl9sZW4gPiBiYXRtYW5f
cGFja2V0LT5udW1faG5hICogRVRIX0FMRU4gPyBiYXRtYW5fcGFja2V0LT5udW1faG5hICogRVRI
X0FMRU4gOiBobmFfYnVmZl9sZW4pOworICAgICAgICAgICAgICAgIHVwZGF0ZV9yb3V0ZXMob3Jp
Z19ub2RlLCBiZXN0X25laWdoX25vZGUsIGhuYV9idWZmLCB0bXBfaG5hX2J1ZmZfbGVuKTsgICAg
ICAgICAKKyAgICAgICAgICAgICAgICAKKyAgICAgICAgICAgICAgICAvKiBSZXNvbHZpbmcgdGhl
IHRtcHQgbG9vcGluZzogb25seSB3aGVuIGJlc3RfbmVpZ2hfbm9kZSBoYXMgdXAtdG8tZGF0ZSBz
ZXFubywgc3dpdGNoIHRvIGl0ICovCisgICAgICAgIH1lbHNlIGlmKGJlc3RfbmVpZ2hfbm9kZS0+
c2Vxbm8gPiBvcmlnX25vZGUtPnJvdXRlci0+c2Vxbm8peyAgICAgICAgICAgICAgICAKKyAgICAg
ICAgICAgICAgICB0bXBfaG5hX2J1ZmZfbGVuID0gKGhuYV9idWZmX2xlbiA+IGJhdG1hbl9wYWNr
ZXQtPm51bV9obmEgKiBFVEhfQUxFTiA/IGJhdG1hbl9wYWNrZXQtPm51bV9obmEgKiBFVEhfQUxF
TiA6IGhuYV9idWZmX2xlbik7CisgICAgICAgICAgICAgICAgdXBkYXRlX3JvdXRlcyhvcmlnX25v
ZGUsIGJlc3RfbmVpZ2hfbm9kZSwgaG5hX2J1ZmYsIHRtcF9obmFfYnVmZl9sZW4pOworICAgICAg
ICB9CiB9CiAKIHN0YXRpYyBjaGFyIGNvdW50X3JlYWxfcGFja2V0cyhzdHJ1Y3QgZXRoaGRyICpl
dGhoZHIsIHN0cnVjdCBiYXRtYW5fcGFja2V0ICpiYXRtYW5fcGFja2V0LCBzdHJ1Y3QgYmF0bWFu
X2lmICppZl9pbmNvbWluZykKQEAgLTM2Nyw3ICszNzYsMTAgQEAKIAljaGFyIGhhc19kaXJlY3Rs
aW5rX2ZsYWc7CiAJY2hhciBpc19teV9hZGRyID0gMCwgaXNfbXlfb3JpZyA9IDAsIGlzX215X29s
ZG9yaWcgPSAwLCBpc19icm9hZGNhc3QgPSAwLCBpc19iaWRpcmVjdGlvbmFsLCBpc19zaW5nbGVf
aG9wX25laWdoLCBpc19kdXBsaWNhdGU7CiAJdW5zaWduZWQgc2hvcnQgaWZfaW5jb21pbmdfc2Vx
bm87Ci0KKyAgICAgICAgCisgICAgICAgIHN0cnVjdCBuZWlnaF9ub2RlICp0bXBfbmVpZ2hfbm9k
ZSA9IE5VTEw7CisgICAgICAgIAorICAgICAgICAKIAkvKiBjb3VsZCBiZSBjaGFuZ2VkIGJ5IHNj
aGVkdWxlX293bl9wYWNrZXQoKSAqLwogCWlmX2luY29taW5nX3NlcW5vID0gYXRvbWljX3JlYWQo
JmlmX2luY29taW5nLT5zZXFubyk7CiAKQEAgLTQzNSwyMiArNDQ3LDM1IEBACiAJCXJldHVybjsK
IAl9CiAKKyAgICAgICAgb3JpZ19ub2RlID0gZ2V0X29yaWdfbm9kZShiYXRtYW5fcGFja2V0LT5v
cmlnKTsKKwlpZiAob3JpZ19ub2RlID09IE5VTEwpCisJCXJldHVybjsKKworICAgICAgICAvKiBX
aGVuIHRoZSBlY2hvIGNvbnRhaW5zIGEgdHEgZnJvbSBuZWlnaGJvciB0aGF0IGlzIHdvcnNlCisg
ICAgICAgICAqIHRoYW4gdGhlIGN1cnJlbnQgYXZlcmFnZSB2aWEgdGhhdCBuZWlnaGJvciwgdXBk
YXRlIHRoZSBhdmcKKyAgICAgICAgICogdHEgdG8gY2lyY3VtdmVudCB0aGUgc3RhbGUgdHEgcmVh
ZGluZyAqLwogCWlmIChpc19teV9vbGRvcmlnKSB7CisgICAgICAgICAgICAgICAgbGlzdF9mb3Jf
ZWFjaF9lbnRyeSh0bXBfbmVpZ2hfbm9kZSwgJm9yaWdfbm9kZS0+bmVpZ2hfbGlzdCwgbGlzdCkg
eyAgICAgICAgICAgICAgICAgICAgICAgIAorICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGNv
bXBhcmVfb3JpZyh0bXBfbmVpZ2hfbm9kZS0+YWRkciwgZXRoaGRyLT5oX3NvdXJjZSkgJiYgKHRt
cF9uZWlnaF9ub2RlLT5pZl9pbmNvbWluZyA9PSBpZl9pbmNvbWluZykpIHsKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaWYoYmF0bWFuX3BhY2tldC0+dHEgPCB0bXBfbmVpZ2hfbm9k
ZS0+dHFfYXZnKXsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByaW5n
X2J1ZmZlcl9zZXQodG1wX25laWdoX25vZGUtPnRxX3JlY3YsICZ0bXBfbmVpZ2hfbm9kZS0+dHFf
aW5kZXgsIGJhdG1hbl9wYWNrZXQtPnRxKTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB0bXBfbmVpZ2hfbm9kZS0+dHFfYXZnID0gcmluZ19idWZmZXJfYXZnKHRtcF9u
ZWlnaF9ub2RlLT50cV9yZWN2KTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQor
ICAgICAgICAgICAgICAgICAgICAgICAgfQorICAgICAgICAgICAgICAgIH0KKyAgICAgICAgICAg
ICAgICAKIAkJZGVidWdfbG9nKExPR19UWVBFX0JBVE1BTiwgIkRyb3AgcGFja2V0OiBpZ25vcmlu
ZyBhbGwgcmVicm9hZGNhc3QgZWNob3MgKHNlbmRlcjogJXMpIFxuIiwgbmVpZ2hfc3RyKTsKIAkJ
cmV0dXJuOwogCX0KLQorICAgICAgICAKIAlpc19kdXBsaWNhdGUgPSBjb3VudF9yZWFsX3BhY2tl
dHMoZXRoaGRyLCBiYXRtYW5fcGFja2V0LCBpZl9pbmNvbWluZyk7Ci0KLQlvcmlnX25vZGUgPSBn
ZXRfb3JpZ19ub2RlKGJhdG1hbl9wYWNrZXQtPm9yaWcpOwotCWlmIChvcmlnX25vZGUgPT0gTlVM
TCkKLQkJcmV0dXJuOwotCisgICAgICAgIAorICAgICAgICAKIAkvKiBpZiBzZW5kZXIgaXMgYSBk
aXJlY3QgbmVpZ2hib3IgdGhlIHNlbmRlciBtYWMgZXF1YWxzIG9yaWdpbmF0b3IgbWFjICovCiAJ
b3JpZ19uZWlnaF9ub2RlID0gKGlzX3NpbmdsZV9ob3BfbmVpZ2ggPyBvcmlnX25vZGUgOiBnZXRf
b3JpZ19ub2RlKGV0aGhkci0+aF9zb3VyY2UpKTsKIAlpZiAob3JpZ19uZWlnaF9ub2RlID09IE5V
TEwpCiAJCXJldHVybjsKLQorICAgICAgICAKIAkvKiBkcm9wIHBhY2tldCBpZiBzZW5kZXIgaXMg
bm90IGEgZGlyZWN0IG5laWdoYm9yIGFuZCBpZiB3ZSBkb24ndCByb3V0ZSB0b3dhcmRzIGl0ICov
CiAJaWYgKCFpc19zaW5nbGVfaG9wX25laWdoICYmIChvcmlnX25laWdoX25vZGUtPnJvdXRlciA9
PSBOVUxMKSkgewogCQlkZWJ1Z19sb2coTE9HX1RZUEVfQkFUTUFOLCAiRHJvcCBwYWNrZXQ6IE9H
TSB2aWEgdW5rbm93biBuZWlnaGJvciEgXG4iKTsK

--0__=4EBBFC90DFBC474B8f9e8a93df938690918c4EBBFC90DFBC474B--

