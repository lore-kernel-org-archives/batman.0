Return-Path: <Jake.Harris@zf.com>
From: <Jake.Harris@zf.com>
Date: Mon, 15 Oct 2018 19:52:37 +0000
Message-ID: <B99A1AB9A294834C8DF94185A5E9D1810163770BE6@NRTV96002.america.zf-world.com>
References: <B99A1AB9A294834C8DF94185A5E9D1810163770B9A@NRTV96002.america.zf-world.com>
 <8325261.HzsDqFlXlC@bentobox>
In-Reply-To: <8325261.HzsDqFlXlC@bentobox>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Blacklisting specific nodes for traffic routing
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sven@narfation.org, b.a.t.m.a.n@lists.open-mesh.org

Made the change on the mobile nodes about 5 hours ago, seems to be effectiv=
e, thank you!

-----Original Message-----
From: Sven Eckelmann <sven@narfation.org>
Sent: Monday, October 15, 2018 11:31
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Harris Jake LPR <Jake.Harris@zf.com>
Subject: Re: [B.A.T.M.A.N.] Blacklisting specific nodes for traffic routing

* PGP Signed by an unknown key

On Montag, 15. Oktober 2018 14:20:32 CEST Jake.Harris@zf.com wrote:
> I'm working with a group of about 50 nodes, 40 of which are physically st=
ationary and 10 are mobile. The area is about three football fields with al=
l the nodes evenly distributed while the 10 move around throughout the whol=
e area (specifically there is one on each machine in the factory and one on=
 each fork truck) with all of the fork truck nodes powered off the network =
is rock solid, but when they are powered up the network becomes flaky with =
different machine nodes loosing connection.
>
> My assumption is the machines notice a fork truck nearby and route their =
traffic through it as would make sense from their algorithm, but when the h=
ilo goes out of range they seem to not notice and packets sent to the out o=
f range nodes are lost.
>
> I looked all over the documentation and haven't found a way to specify wh=
ich nodes to not allow routes to be built through.
[...]
> Is there an official way of doing either of these?

If you want to make it unlikely that routes are planned through some nodes =
then try to increase the hop_penalty on these devices [1].

Kind regards,
        Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Tweaking#hop-penalty

* Unknown Key
* 0xC1267B46
