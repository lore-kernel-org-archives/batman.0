Return-Path: <Yang.Su@ascom.CH>
In-Reply-To: <200908062215.42266.lindner_marek@yahoo.de>
References: <20090722105639.GH32143@ma.tech.ascom.ch>	<200908031821.22497.lindner_marek@yahoo.de>
	<OFC1B28E77.E7123900-ONC125760A.0028654D-C125760A.00300451@CHASCOM.INT>
	<200908062215.42266.lindner_marek@yahoo.de>
Message-ID: <OF7EA947EA.4A9F255F-ONC125760B.00526255-C125760B.0053A890@CHASCOM.INT>
From: Yang Su <Yang.Su@ascom.CH>
Date: Fri, 7 Aug 2009 17:13:46 +0200
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=4EBBFC98DFC1E4C58f9e8a93df938690918c4EBBFC98DFC1E4C5"
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--0__=4EBBFC98DFC1E4C58f9e8a93df938690918c4EBBFC98DFC1E4C5
Content-type: text/plain; charset=US-ASCII






> - This approach achieves the similar goal as the seqno-based one: switch
to
> a neighbor only when this neighbor is better and has more up-to-date
> information than the current best route. But this approach is less
> constrained and seems not to suffer from the above problem for the
> seqno-based approach. I have tested the patch on our test environment. It
> works pretty well on the test cases.

Great! I comitted the patch immediately. Thanks again for your thorough
analysis and ideas. :-)

- Some updates: I did more thorough testing. It turns out that this patch
does really solve the problem.  This method seems not able to completely
eliminate all possible forms of looping which happen in the test cases.
This result in an special pattern: the rerouting is fast (~15 seconds),
then (after 3~ 5 seconds) the network enters the looping state and it
normally takes long time to recover.  Last time when I did tests, I stop
the tests right after I observed the successful rerouting. I didn't look
into the cause of this problem yet. Any inputs are welcome.

> - The problem might happen when the neighbor thinks that I am his best
> neighbor (his good number is actually from me). In this case, my
estimation
> of that neighbor's TQ is actually decided by my own TQ (my TQ minus one
hop
> penalty). When my TQ drops down, the correct behavior should be that my
> estimation of that neighbor's TQ also drops down accordingly. However,
when
> echo cancellation steps in, my estimation of that neighbor's TQ will not
be
> updated and remains to be the stale value. This might cause problems
(e.g.
> looping) in corner cases even with the new patch.  Does this analysis
make
> sense or I miss some details of the echo cancellation?

Unless you found another bug the echo cancellation should not hinder the
propagation of our own TQ value. Once we (uml2) received a packet we will
rebroadcast it. Our neighbor (uml1) will receive it (unless the packet got
lost) and update its routing tables accordingly. Now, he will rebroadcast
the
packet as well which will be killed by the echo cancellation on uml1 as
this
packet does not contain new information.
But even if the TQ received via uml2 is worse uml1 might still have a good
TQ
from uml3 in its routing table which might get rebroadcasted.

- In the following example (also appended in the attachment :) ), if I
understand the current echo cancellation implementation correctly, batman
will enter permanent looping between A and B. In this example, A send to F,
all the links are perfect and have the same delay. Only exception is link
A-E. It is an asymmetric link.

Regards,
Yang
(See attached file: looping.pdf)

--0__=4EBBFC98DFC1E4C58f9e8a93df938690918c4EBBFC98DFC1E4C5
Content-type: application/pdf; 
	name="looping.pdf"
Content-Disposition: attachment; filename="looping.pdf"
Content-transfer-encoding: base64

JVBERi0xLjUNCiW1tbW1DQoxIDAgb2JqDQo8PC9UeXBlL0NhdGFsb2cvUGFnZXMgMiAwIFIvTGFu
Zyhlbi1VUykgL1N0cnVjdFRyZWVSb290IDExIDAgUi9PdXRsaW5lcyA4IDAgUi9NYXJrSW5mbzw8
L01hcmtlZCB0cnVlPj4+Pg0KZW5kb2JqDQoyIDAgb2JqDQo8PC9UeXBlL1BhZ2VzL0NvdW50IDEv
S2lkc1sgMyAwIFJdID4+DQplbmRvYmoNCjMgMCBvYmoNCjw8L1R5cGUvUGFnZS9QYXJlbnQgMiAw
IFIvUmVzb3VyY2VzPDwvRm9udDw8L0YxIDUgMCBSPj4vUHJvY1NldFsvUERGL1RleHQvSW1hZ2VC
L0ltYWdlQy9JbWFnZUldID4+L01lZGlhQm94WyAwIDAgNTk2LjI1IDg0M10gL0NvbnRlbnRzIDQg
MCBSL0dyb3VwPDwvVHlwZS9Hcm91cC9TL1RyYW5zcGFyZW5jeS9DUy9EZXZpY2VSR0I+Pi9UYWJz
L1MvU3RydWN0UGFyZW50cyAwPj4NCmVuZG9iag0KNCAwIG9iag0KPDwvRmlsdGVyL0ZsYXRlRGVj
b2RlL0xlbmd0aCAxMTYxPj4NCnN0cmVhbQ0KeJzVWElrZEcMvj94/6EugZ7AyLUvwRjiticLGQik
/0BIMg6DnUMu+ftRLaqn8ltmfGwbbKSSVNInlaRucfOruL29+Xj+6UHIuztx/3AWErQV/82TFD/M
k1DiZ4F/PospeTAhChcDxChe5s5IGlwUSkpQCSnkJqRslmrUH/OkZMpSdKxM/keqjaqWs/DAOKK4
sMn30z0hgYndjUoVN6qXldFDKqpjgCj89zz9hhA8fjwLwYBSDaj7yzzdfFAImMo/4vJpnoIWEn/x
n5IatEJrDmwUl5cM6NM8nb5/d/k8T4+XDcO6GcaQJDgnnI2gM9JEOw0xg2fBeKQ8BCQSSCJygNpA
cHSoAzjf9RpVrBZRRu8TXNKAE3SDSeBTv79SJR3VOzpukRRNHtY+vobhy/BUpXKcdVDhPN3vI2k7
kj7kcl6QbHRDJCiQHazgFuRyIFGCtXQYLeglA43q+HB6n+CSBY92Q4Oq3b8g2bxrxxRJ0eRh7SPp
tpEMGITnSJ73kfSEpFZYyGZBkuiKiMYy0ASWxgpJdkFS6wje0KHRFdaq1ygKZKD3CS6Z8aAbKlR0
f0eSvGvHFEnR5GHtIxk2kdS6ZmhB8mEfydiRNBE7BmukxKjdUFsFSVOn1NaDV6yRaqfAdIZ2DpTu
qo3qHWxkHFFcuHRDuqd2SnKjN1Lysh1TSFV1CHAf1LQNKuYlOd44T4/7qCoaW5ORHpRlsBKjYmNw
MGSzFTeDXco7BqvBEjG2H2MFKddVG9XjGRlHFBcu2NA9FTdyo8NKXrZjCqmqDgEezCe1iatROJAG
WD8cwKr7NpDyhEvG5L/4ev59yj2eDZ0ynzRItO0ioNxzHQJ57vo8Gwsj+57LxYKqEtKARhPYixCO
wuCjuthoFRZyW3yuK0S+FftkClUCkUAJrzJmmaEl+HwtTqhqlDv6XBD79O08XXUAmymnmTluRy+L
gWTy6GUWY4JYIqNGumJ0lfE9c5Wy4nCGo0DolhWDVEZPh9xccwib2aF1ZL2NKHABaWwztaiI4UHX
CjFYZWaL0VX4rsYEnIE4aDiZC5hdsmZ0Fe4nT831+r+ZF9qPVrsNPtTgmZOd0cPAUstve83ocfHN
jwksThKDwqBL1gxSGfxkebli/zfzQkvnuKLkwLAfh8TfdWP0l2/wA54NG4yuMo5RrkLvujPo5fdb
VozePQZPeWquOoTN7NAuPGzkZY2V9aHiiKSOistD2fRrz7W1X4bug0UfVJmQylcGXzMLI0JEm8Hk
raVJ5G0K5zAuI+UWBz4/fpU/AbRWnzcsLEM7dPbVq7le/zfzEm9++f2fJ3H686/35x/fbX/0c/VL
CayklFZfSkiQwSoZUfbygFzR98PXVuq7Xqyc3u+Jel1ePBO9o7u8jfHLd3mEUg8GHt/mbPD1m6jF
wHdkwMiISfiSgajyUsgNqB6CCvhBsxmQewYS1tUYwjcHm3f6ijTakOurFJGrFt+aQYsr/WDg9iDZ
paQX0aNk4zThovtptWDTIPp4UAFx9PWNCUTNV24dJfCr04qN0uvB7Ku0/g/L2wfWDQplbmRzdHJl
YW0NCmVuZG9iag0KNSAwIG9iag0KPDwvVHlwZS9Gb250L1N1YnR5cGUvVHJ1ZVR5cGUvTmFtZS9G
MS9CYXNlRm9udC9BcmlhbC9FbmNvZGluZy9XaW5BbnNpRW5jb2RpbmcvRm9udERlc2NyaXB0b3Ig
NiAwIFIvRmlyc3RDaGFyIDMyL0xhc3RDaGFyIDcwL1dpZHRocyAzMCAwIFI+Pg0KZW5kb2JqDQo2
IDAgb2JqDQo8PC9UeXBlL0ZvbnREZXNjcmlwdG9yL0ZvbnROYW1lL0FyaWFsL0ZsYWdzIDMyL0l0
YWxpY0FuZ2xlIDAvQXNjZW50IDkwNS9EZXNjZW50IC0yMTAvQ2FwSGVpZ2h0IDcyOC9BdmdXaWR0
aCA0NDEvTWF4V2lkdGggMjY2NS9Gb250V2VpZ2h0IDQwMC9YSGVpZ2h0IDI1MC9MZWFkaW5nIDMz
L1N0ZW1WIDQ0L0ZvbnRCQm94WyAtNjY1IC0yMTAgMjAwMCA3MjhdID4+DQplbmRvYmoNCjcgMCBv
YmoNCjw8L1RpdGxlKCkvQXV0aG9yKG5zdXlhbikvU3ViamVjdCgpL0tleXdvcmRzKCkvQ3JlYXRp
b25EYXRlKEQ6MjAwOTA4MDcxNDU4NDYpIC9Nb2REYXRlKEQ6MjAwOTA4MDcxNDU4NDYpIC9Qcm9k
dWNlcij+/wBNAGkAYwByAG8AcwBvAGYAdACuACAATwBmAGYAaQBjAGUAIABWAGkAcwBpAG8ArgAg
ADIAMAAwADcpL0NyZWF0b3Io/v8ATQBpAGMAcgBvAHMAbwBmAHQArgAgAE8AZgBmAGkAYwBlACAA
VgBpAHMAaQBvAK4AIAAyADAAMAA3KT4+DQplbmRvYmoNCjggMCBvYmoNCjw8L1R5cGUvT3V0bGlu
ZXMvRmlyc3QgOSAwIFIvTGFzdCAxMCAwIFI+Pg0KZW5kb2JqDQo5IDAgb2JqDQo8PC9UaXRsZShE
cmF3aW5nMSkvUGFyZW50IDggMCBSL0ZpcnN0IDEwIDAgUi9MYXN0IDEwIDAgUi9Db3VudCAtMS9E
ZXN0WyAwL1hZWiAwIDg0MSAwXSA+Pg0KZW5kb2JqDQoxMCAwIG9iag0KPDwvVGl0bGUoUGFnZS0x
KS9QYXJlbnQgOSAwIFIvRGVzdFsgMC9YWVogMCA4NDEgMF0gPj4NCmVuZG9iag0KMTYgMCBvYmoN
Cjw8L1R5cGUvT2JqU3RtL04gMTgvRmlyc3QgMTIyL0ZpbHRlci9GbGF0ZURlY29kZS9MZW5ndGgg
MzM0Pj4NCnN0cmVhbQ0KeJylk0FLw0AQhe+F/od31Ivb2exudqEUvHgplNL2Jh7ULkGoVmIC9t87
u2OVaEmkQuAls28+ZmYzZDABlShKkEdpQAFEBM1R46GJwxZa82OgC2hfgt8KyxELw5nawXg+KGFN
4HM44oQAZzm3gOME5nlGkIYPHnwcmDudqmUyTLBSa7VU89tUyR3UskKOzmbj0QmTRjFsMrDDJody
2OQRhk3ElfeXfvNUtXVU17vmwlhsY1XHiO2+fdjFy0zQ56ZfeQH0T6UPEARgzgbQRAj9M+8lkBDc
+QQthD9cKfk/eE7fOh0991UkmVqKpA3K4kVCFt6hLCSiRQoRyeMdyuJEhKKFojPldxmbw2tU66Zu
H5sND2C13zdcTx1f8mfaslRj/iWOgK/TRXxv5vEA+mQt2ue3vHdWrCn83VS3t26LnU5/NNzt+5/t
j0cfQe4OpQ0KZW5kc3RyZWFtDQplbmRvYmoNCjMwIDAgb2JqDQpbIDI3OCAwIDAgMCAwIDg4OSAw
IDAgMCAwIDAgMCAwIDMzMyAwIDAgNTU2IDU1NiAwIDAgMCAwIDAgMCAwIDAgMjc4IDAgNTg0IDAg
NTg0IDAgMCA2NjcgNjY3IDcyMiA3MjIgNjY3IDYxMV0gDQplbmRvYmoNCjMxIDAgb2JqDQo8PC9U
eXBlL1hSZWYvU2l6ZSAzMS9XWyAxIDQgMl0gL1Jvb3QgMSAwIFIvSW5mbyA3IDAgUi9JRFs8QTZE
OTZCNDY3MzRBMEI0MEFGOTc2MkJFNkY0MTE1QjY+PEE2RDk2QjQ2NzM0QTBCNDBBRjk3NjJCRTZG
NDExNUI2Pl0gL0ZpbHRlci9GbGF0ZURlY29kZS9MZW5ndGggOTc+Pg0Kc3RyZWFtDQp4nDXN2wmA
MAyF4VNvVeutEziOc/nuKoLgCo4l1Npf85CPQxIixQrBxO6llw2uhNkT1ZqwM4RE08ICp5TFu0kj
TDDAN/Pv5v0nAxnkUEAJFViooYEWHHTQxw/ukB7qYwqJDQplbmRzdHJlYW0NCmVuZG9iag0KeHJl
Zg0KMCAzMg0KMDAwMDAwMDAxMSA2NTUzNSBmDQowMDAwMDAwMDE3IDAwMDAwIG4NCjAwMDAwMDAx
NDAgMDAwMDAgbg0KMDAwMDAwMDE5NiAwMDAwMCBuDQowMDAwMDAwNDI5IDAwMDAwIG4NCjAwMDAw
MDE2NjUgMDAwMDAgbg0KMDAwMDAwMTgyMyAwMDAwMCBuDQowMDAwMDAyMDQ3IDAwMDAwIG4NCjAw
MDAwMDIzMTQgMDAwMDAgbg0KMDAwMDAwMjM3NSAwMDAwMCBuDQowMDAwMDAyNDgzIDAwMDAwIG4N
CjAwMDAwMDAwMTIgNjU1MzUgZg0KMDAwMDAwMDAxMyA2NTUzNSBmDQowMDAwMDAwMDE0IDY1NTM1
IGYNCjAwMDAwMDAwMTUgNjU1MzUgZg0KMDAwMDAwMDAxNiA2NTUzNSBmDQowMDAwMDAwMDE3IDY1
NTM1IGYNCjAwMDAwMDAwMTggNjU1MzUgZg0KMDAwMDAwMDAxOSA2NTUzNSBmDQowMDAwMDAwMDIw
IDY1NTM1IGYNCjAwMDAwMDAwMjEgNjU1MzUgZg0KMDAwMDAwMDAyMiA2NTUzNSBmDQowMDAwMDAw
MDIzIDY1NTM1IGYNCjAwMDAwMDAwMjQgNjU1MzUgZg0KMDAwMDAwMDAyNSA2NTUzNSBmDQowMDAw
MDAwMDI2IDY1NTM1IGYNCjAwMDAwMDAwMjcgNjU1MzUgZg0KMDAwMDAwMDAyOCA2NTUzNSBmDQow
MDAwMDAwMDI5IDY1NTM1IGYNCjAwMDAwMDAwMDAgNjU1MzUgZg0KMDAwMDAwMjk5MiAwMDAwMCBu
DQowMDAwMDAzMTIxIDAwMDAwIG4NCnRyYWlsZXINCjw8L1NpemUgMzIvUm9vdCAxIDAgUi9JbmZv
IDcgMCBSL0lEWzxBNkQ5NkI0NjczNEEwQjQwQUY5NzYyQkU2RjQxMTVCNj48QTZEOTZCNDY3MzRB
MEI0MEFGOTc2MkJFNkY0MTE1QjY+XSA+Pg0Kc3RhcnR4cmVmDQozNDE3DQolJUVPRg0KeHJlZg0K
MCAwDQp0cmFpbGVyDQo8PC9TaXplIDMyL1Jvb3QgMSAwIFIvSW5mbyA3IDAgUi9JRFs8QTZEOTZC
NDY3MzRBMEI0MEFGOTc2MkJFNkY0MTE1QjY+PEE2RDk2QjQ2NzM0QTBCNDBBRjk3NjJCRTZGNDEx
NUI2Pl0gL1ByZXYgMzQxNy9YUmVmU3RtIDMxMjE+Pg0Kc3RhcnR4cmVmDQo0MjEyDQolJUVPRg==

--0__=4EBBFC98DFC1E4C58f9e8a93df938690918c4EBBFC98DFC1E4C5--

