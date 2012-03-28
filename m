Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAHD-aqLmGQwzK1u8vmgEwpbNTPMZuonJikjkT=uaOkcPedFptg@mail.gmail.com>
References: <CAHD-aqKv+7SDGC-07Or+xOZKiJATPmOy876SnDawJp_Zs0GZvg@mail.gmail.com>
	<201203261747.17373.lindner_marek@yahoo.de>
	<CAHD-aqLmGQwzK1u8vmgEwpbNTPMZuonJikjkT=uaOkcPedFptg@mail.gmail.com>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Wed, 28 Mar 2012 19:41:05 -0300
Message-ID: <CAHD-aqLs8kr5Bwk4-5gBuNepQUmX78yeAHRxRjSLQJw10=fkyA@mail.gmail.com>
Content-Type: multipart/mixed; boundary=20cf305e24b9c494d904bc554e05
Subject: Re: [B.A.T.M.A.N.] BW degradation on p2p links?
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

--20cf305e24b9c494d904bc554e05
Content-Type: text/plain; charset=UTF-8

(this time i'll keep the mail short, insane details are attached as text :) )

Well, luckily for batman-adv devs, but unfortunately for me, the
problem is in fact related to relaying between wlan interfaces in
mr3x20 hardware (at least)

I understand this is not anymore batman related, but maybe someone has
experience on this, or can point me into the right direction /
maillist ?
Given you have a good deal of equipments at the BattleMesh, maybe
someone has already tried adding a wifi dongle and can confirm seeing
this behaviour?
(in a line of 2-radio nodes with static routing, packet throughput is
halved on each hop)

========

I've repeated the iperf tests in a controlled environment, this time
using different subnets on each interface and static routes built with
"route add". iptables flushed with -F and policy -P FORWARD ACCEPT
no batman at all.

Packets coming in through wlan1 and out through wlan0 (or viceversa)
experience (unexpected) "bandwidth degradation". Throughput drops from
30mbps to 15mbps (rough avg)
The speed is closely comparable to using only 1 radio (packet comes in
through wlan0, goes out through wlan0), so adding the dongle makes no
net difference. (besides alternating the channel for transmission,
throughput is halved over one hop anyway)
2 consecutive hops, alternating wifi radios, yield 1/3 throughput.
(like it happens in a 1-radio mesh)

this does not happen if the packet comes in through eth0 and goes out
through wlanX (or viceversa) . Throughput is maintained high at
30mbps.

=========

So the hardware (or kernel??) is uncapable of keeping up with the
transfer speed *when two radios are involved*.

Has anyone bumped into a similar case, or has experience with these
equipments? Maybe (again!) i am doing something wrong?

If this is confirmed, my only alternative to maintain good throughput
along the mesh will be to install 2 x mr3220 on each node, connected
back-to-back with ethernet cable. This will definitely work but the
cost for each node owner evidently rises ;(

Thanks a lot!

Guido

--20cf305e24b9c494d904bc554e05
Content-Type: application/octet-stream; name=iperfs-forwarding
Content-Disposition: attachment; filename=iperfs-forwarding
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0cxm6zt0

Li4gbXIzNDIwIC4uLi4uLiBtcjMyMjArNzIyIC4uLi4uLiBtcjMyMjAgLi4uLi4uIFRYIC8gUlgK
W2NwdSAgZXRoMF0gLT4gW2V0aDAgICAgY3B1XSAuLi4uLi4uLi4uLi4uLi4uLi4uIDk0IC8gOTIK
W2NwdSB3bGFuMF0gLT4gW3dsYW4xICAgY3B1XSAuLi4uLi4uLi4uLi4uLi4uLi4uIDM1IC8gMzMK
Li4uLi4uLi4uLi4uLi4uW2NwdSAgIHdsYW4wXSAtPiBbd2xhbjAgICBjcHVdIC4uIDMyIC8gMzMK
Li4uLi4uLi4uLi4uLi4uW2NwdSAgIHdsYW4xXSAtPiBbd2xhbjAgICBjcHVdIC4uIDMyIC8gMzUK
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi5bY3B1ICAgd2xhbjBdIC4uIDQ1IC8gMzIK
W2NwdSAgZXRoMF0gLT4gW2V0aDAgIHdsYW4wXSAtPiBbd2xhbjAgICBjcHVdIC4uIDMwIC8gMzQK
W2NwdSAgZXRoMF0gLT4gW2V0aDAgIHdsYW4xXSAtPiBbd2xhbjAgICBjcHVdIC4uIDMyIC8gMzAK
Li4uLi4uLi4uLi4uLi4uW2NwdSAgIHdsYW4wXSAtPiBbd2xhbjAgd2xhbjBdIC4uIDIxIC8gMTYK
W2NwdSB3bGFuMF0gLT4gW3dsYW4xIHdsYW4wXSAtPiBbd2xhbjAgICBjcHVdIC4uIDEzIC8gMTMK
W2NwdSB3bGFuMF0gLT4gW3dsYW4xIHdsYW4xXSAtPiBbd2xhbjAgICBjcHVdIC4uIDE1IC8gMTUK
W2NwdSB3bGFuMF0gLT4gW3dsYW4wIHdsYW4wXSAtPiBbd2xhbjAgICBjcHVdIC4uIDE1IC8gMTUK
W2NwdSB3bGFuMF0gLT4gW3dsYW4wIHdsYW4wXSAtPiBbd2xhbjAgIGV0aDBdIC4uIDE5IC8gMTUK
W2NwdSB3bGFuMF0gLT4gW3dsYW4wIHdsYW4wXSAtPiBbd2xhbjAgd2xhbjBdIC4uIDEzIC8gMTAK
W2NwdSB3bGFuMF0gLT4gW3dsYW4xIHdsYW4wXSAtPiBbd2xhbjAgd2xhbjBdIC4uIDEyIC8gMTAK
CiJtcjMyMjArNzIyIiBoYXMgYSB0cGxpbmsgdGwtd243MjJuIGNvbm5lY3RlZCB0byB1c2IgcG9y
dAoiY3B1IiBtZWFucyBpcGVyZiB0cmFmZmljIHN0YXJ0ZWQgb3IgZW5kZWQgdGhlcmUgKGFzIGEg
Y2xpZW50IG9yIHNlcnZlcikKCmluIGFsbCBjYXNlcyB3bGFuMCByZXByZXNlbnRzIGludGVybmFs
IHdpZmkgKGF0aDlrKQphbmQgd2xhbjEgcmVwcmVzZW50cyB0bC13bjcyMm4gKGF0aDlrX2h0YykK
dGhlIDQgbGluZXMgdGhhdCBlbmQgaW4gIndsYW4wIiBtZWFucyB0aGF0IGluc3RlYWQgb2YgaXBl
cmYgdHJhZmZpYyBlbmRpbmcgaW4gdGhlIGxhc3QgbXIzMjIwLCBpdCB3YXMgZm9yd2FyZGVkIHRv
IGEgbGFwdG9wIChydW5uaW5nIGlwZXJmKSBjb25uZWN0ZWQgdGhyb3VnaCB0aGUgd2lmaSBpbnRl
cmZhY2UgYXMgY2xpZW50Lgp0aGUgbGluZSB0aGF0IGVuZHMgaW4gImV0aDAiIGlzIGFuYWxvZywg
YnV0IHRoZSBsYXB0b3Agd2FzIGNvbm5lY3RlZCB0byB0aGUgc3dpdGNoIHdpdGggYSBjYWJsZS4K
CmNtZGxpbmUgdXNlZCB3YXMgImlwZXJmIC1jIHgueC54LnggLXczMjBrIC1pMSAtTDUwMDIgLXIi
CnN0YXRpYyByb3V0ZXMgd2VyZSBjcmVhdGVkIGFzIG5lZWRlZCB3aXRoICJyb3V0ZSBhZGQiCmFs
bCBzcGVlZHMgbm90ZWQgYXJlIGluIG1lZ2FiaXRzIHBlciBzZWNvbmQgKG1icHMpIGFzIHJlcG9y
dGVkIGJ5IGlwZXJmLg==
--20cf305e24b9c494d904bc554e05--
