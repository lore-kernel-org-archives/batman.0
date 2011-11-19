Return-Path: <ordex@autistici.org>
Date: Sat, 19 Nov 2011 12:04:41 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111119110441.GF30187@ritirata.org>
References: <CAFevQmPcoR3O5FHfHvuUkv4yrJMYd1MtsEMNZ24uwjXaUtXxeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFevQmPcoR3O5FHfHvuUkv4yrJMYd1MtsEMNZ24uwjXaUtXxeQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] batctl ping exit status
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

On Sat, Nov 19, 2011 at 11:43:40 +0100, Filippo Sallemi wrote:
> Hi all,
> I'm working on a simple script that check if node is connected. The
> scope of this script is make every node able to autorescue in case of
> change channel on some gateway node.
> To do this check if i'm not a gateway try to ping my gateway ipaddress
> then if it not respond try to batctl ping my gateway mac and than if
> not respond for a number of tries the node try to find another
> channell with the same bssid.
> The problem is that batct ping every time exit with status 0 istead of
> behaviour of ping command that exit with 1 if ping fail. At this time
> I have to use some regex to check if batctl ping status command. It is
> possible to fix batctl ping to work such as ping command?

I think it is, we just need the proper patch :D
By the way, I see that the ping command returns SUCCESS even if only one
echo_reply is received. Therefore if you send 5 requests and get only 1 reply
(because the node somehow changed channel while you were pinging it), your
script will tell you that the node is UP anyway. Is this the wanted behaviour?

However a meaningful return value for batctl could be a good idea..(not for ping
only)

> 
> Rgds
> 
> -- 
> Filippo Sallemi

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
