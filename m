Return-Path: <ordex@autistici.org>
Date: Thu, 1 Sep 2011 23:35:32 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110901213531.GE840@ritirata.org>
References: <4E5D69E3.30403@robotech.de>
	<CAKeC-QGag_c+g93MbiJWL9HB3iOczbfbatYUAA1wEEFSyvyd2g@mail.gmail.com>
	<20110831160712.GC25149@ritirata.org>
	<201108311816.23147.lindner_marek@yahoo.de>
	<20110831161833.GD25149@ritirata.org>
	<4E5E69DB.5060007@robotech.de>
	<20110831215506.GA27165@ritirata.org>
	<4E5F3F31.7000402@robotech.de> <20110901155545.GA840@ritirata.org>
	<4E5FF4F2.8050309@robotech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4E5FF4F2.8050309@robotech.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thu, Sep 01, 2011 at 11:11:14 +0200, Tobias wrote:
> root@1043-49:~# batctl l | grep "0a:18:84:1e:f6:05"

Can you give me the output of batctl tg and batctl tl on this node (1043-49)?

> root@fon-53:~# brctl show

and ouput of batctl tl of this other node (fon-53)?

Because it seems that we are dealing with more than one bug, so I would like to
distinguish the possible causes.

@Andrew: operation on mac addresses should be bytewise than the architecture
should now be implied in these problems, no?

Thanks,
Antonio
