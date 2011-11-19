Return-Path: <ordex@autistici.org>
Date: Sat, 19 Nov 2011 20:31:08 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111119193108.GI30187@ritirata.org>
References: <CAFevQmM1zCU9k7LJYjMDosjNCEJhrnZ-4krWnX2MiYC9+-SBTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFevQmM1zCU9k7LJYjMDosjNCEJhrnZ-4krWnX2MiYC9+-SBTA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Very strange behaviour
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

Hello Filippo,

On Sat, Nov 19, 2011 at 08:22:41 +0100, Filippo Sallemi wrote:
> Hi,
> I'm just working on script that try to autorecover the node in case of
> failure and I noticed something very strange.
> Ii have 3 node setted to channel 3. Well when I change the channel of
> one of these nodes for example from 3 to 5 after some time I can see
> however the entirely topology of my network.
> 
> How it is possible? My script is not ready and iwconfig output show
> the changed channel!!!!
> 
> apparently do not have the same behavior if channel is far from other
> nodes (es 6)
> 
> This is very very strange for me!
> 

I know you are testing batman-adv on your network, but this particular issue is
not strictly related to batman anymore..

However I'd say that, since channels overlap (yes they do), it is possible that some
devices overhear packets (not all of course) from near channels too. If you want
to be sure that overlapping is not happening, you should choose channel 1, 7 and
13.

By the way this is just my explanation. Could be not correct.

Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
