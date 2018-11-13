Return-Path: <Jake.Harris@zf.com>
From: <Jake.Harris@zf.com>
Date: Tue, 13 Nov 2018 14:55:31 +0000
Message-ID: <B99A1AB9A294834C8DF94185A5E9D18101784D2AFE@NRTV96002.america.zf-world.com>
References: <B99A1AB9A294834C8DF94185A5E9D18101784CE751@NRTV96002.america.zf-world.com>
 <3795505.rC9BEUj0Hg@prime>
 <B99A1AB9A294834C8DF94185A5E9D18101784D2A0E@NRTV96002.america.zf-world.com>
 <5197276.b4DnEGo6x7@prime>
In-Reply-To: <5197276.b4DnEGo6x7@prime>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] broadcast storms
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sw@simonwunderlich.de
Cc: b.a.t.m.a.n@lists.open-mesh.org

> Mhm, this is really not much data ... did you try the multicast as sugges=
ted in an earlier reply?

What earlier reply are you referring to? The only one I'm noticing is the t=
ip to boost the multicast bandwidth, but I cannot see this being fruitful t=
o update the configuration of all 50 nodes when worst-case I'm using less t=
han 1% of the max throughput.

> BATADV_RESET_PROTECTION_MS is a define in the batman-adv C-code, so it ca=
n't be set at runtime but only at compile time.

While this sounds like an utter pain in the butt to recompile and update th=
e code on all the nodes to make this change, I believe this has a far bette=
r chance of alleviating the issue, I'm looking into how to do this since I'=
ve never compiled anything myself but I can't see it being too difficult.

One observation I made when rebooting the swarm all at once, about a minute=
 after all the pi's go down the laptop I work off (running batctl td bat0) =
reports a whole bunch of backbone unannounced messages I believe. I'm assum=
ing there is one message per node but have not verified, my guess is this i=
s normal and is not the cause of these issues?

Again, thank you
