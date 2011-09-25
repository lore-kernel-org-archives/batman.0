Return-Path: <ordex@autistici.org>
Date: Sun, 25 Sep 2011 18:05:20 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110925160519.GA4631@ritirata.org>
References: <20110919224529.GB3410@ritirata.org> <4E7ED5D3.2000600@wifibot.com>
	<20110925073942.GA2993@ritirata.org> <4E7EE7A9.7010309@wifibot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4E7EE7A9.7010309@wifibot.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Laurent,

On Sun, Sep 25, 2011 at 10:34:49 +0200, laurent wrote:
> Hello,
> 
> thank you for your fast reply.
> Some precision I use openwrt backfire and each node have eth0 bridged to
> bat0.
> 
> <What about the TT log? does it say something?
> 
> I do not have debug on this version, but I can re flash a new firmware.
> Do I need to  flash all the nodes ?
> 

wel..it would be better to have the log (yes you have to enable the debug and
reflash the nodes for this...), so that we can try to understand what it is
going on in that period of time.

I'm going to send to the ml a patch that will enable a more verbose log so that
we can obtain more information in one shot.

Please apply that patch on top of
the master branch (it should be easy with openwrt. Ask here if you have
problems).

Then, it would be nice if you could copy & paste here the log obtained from two
not working nodes. Once you will post the logs we will decide how to further
inspect the problem. Unluckily it seems to be a arch (or what else) related problem
which makes it unreproducible with my (our) routers.

Cheers,


1) the patch will follow in this thread.
2) I think it is easier to read the log than inspect the graph data
3) I just noticed this was a private mail. Please keep the conversation public
so that all the other people can contribute to solve the issue ;);)



-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
