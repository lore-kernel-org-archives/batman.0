Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: Network stops passing traffic randomly
References: <c022e032-f283-8432-2d3e-3013cf91773b@coolheads.com>
 <20200529001302.832.66710@diktynna.open-mesh.org>
From: Steve Newcomb <srn@coolheads.com>
Message-ID: <174b4bab-d84e-899d-3ecf-34bfdccff4fd@coolheads.com>
Date: Mon, 1 Jun 2020 22:05:04 -0400
MIME-Version: 1.0
In-Reply-To: <20200529001302.832.66710@diktynna.open-mesh.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Reply-To: srn@coolheads.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Ben Greear <greearb@candelatech.com>, smartwires@gmail.com



On 5/28/20 8:13 PM, smartwires@gmail.com wrote:
> Steve, I am also using ap with a QCA9558 SOC and Also using ath10k-firm=
ware-qca988x . I have also considered using adhoc.

I think I discovered something yesterday that explains everything, and=20
it's very reproducible.=C2=A0 The mesh mode in the QCA firmware works=20
reliably in the lab and in the field, but only when there are 3 or fewer=20
nodes.=C2=A0 If I add one more node, the mesh will completely fail, eithe=
r=20
immediately or within a few hours.=C2=A0 If the nodes are strung out in a=
=20
daisy chain, failure is usually, but not always, delayed for a while,=20
and the links break in a piecemeal fashion, one at a time.=C2=A0 If the n=
odes=20
are close enough to each other, total failure occurs quite quickly.=C2=A0=
 I=20
surmise that the 802.11s implementation in the QCA driver was not tested=20
with more than 3 nodes, or perhaps it wasn't designed to support more=20
than 3 nodes.=C2=A0 Sigh.

Sven, I think this epiphany obviates the need for your test (which I=20
still haven't figured out how to execute in the field), but I'll return=20
to that effort if you think I should.

So in the end, unless I replace the hardware throughout the neighborhood=20
with far more expensive hardware, I must find a way to use Ben's driver,=20
or to have no mesh network with more than 3 nodes in it.

