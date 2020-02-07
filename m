Return-Path: <srn@coolheads.com>
Reply-To: srn@coolheads.com
Subject: Re: can't find logged information
References: <24aa48bb-8f52-78be-28df-98ec2e2a054b@coolheads.com>
 <b696db36-b9db-d31a-d8a6-0523f8a0986c@coolheads.com>
 <1594276.uRpPO4E4fP@prime>
From: Steve Newcomb <srn@coolheads.com>
Message-ID: <60314915-68db-93c4-c35f-0a593015c7ba@coolheads.com>
Date: Fri, 7 Feb 2020 11:59:27 -0500
MIME-Version: 1.0
In-Reply-To: <1594276.uRpPO4E4fP@prime>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org


On 2/7/20 10:52 AM, Simon Wunderlich wrote:
>
> Oops, you are right, we have actually removed that command in 2019.2. You=
 can
> use one of the two following commands:
>
> cat /sys/kernel/debug/batman_adv/bat0/log
The cat method works.=A0 Thanks.=A0 Wow, with all the debug info selected, =

it's a torrent of stuff.=A0 (Which I expected.)

>
> (will be removed in the future when debugfs support is dropped
>
>   trace-cmd stream -e batadv:batadv_dbg
Uh, *which* of the two above commands will be dropped?=A0 Should I add=20
trace-cmd to my menuconfig to retain access to the logs?=A0 I haven't=20
added it yet.

 > By "works" you mean you get useful outputs where the timeout is not=20
increasing or similar? can you still "batctl ping" to one of your neighbors?

You are far ahead of where I am.=A0 I meant only that I was getting what=20
appears to be useful information, not that I have interpreted it.=A0 It=20
will take me a while to figure out how to read it.=A0 I would be grateful=20
for any hints on that, and I'm already very grateful for the help you=20
have provided.

I haven't been using "batctl ping" to cue a reboot; I've been using=20
"ping".=A0 I'm not sure what difference it might make to use "batctl=20
ping"; it seems to me that if I can't "ping" a node, after 3 or 4 trials=20
over a period of 15-20 seconds, I'm no longer in touch with it in any=20
usable way.=A0 When that happens, as long as I don't reboot the gateway,=20
everything just stays offline.=A0 So it's better to reboot.

By the way, at least one user is using the mesh for landline telephone=20
(Google Voice) service, so I'd really like to stabilize it if I can.
