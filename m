Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 9 Mar 2013 04:06:42 +0800
References: <1362764336-1591-1-git-send-email-linus.luessing@web.de>
 <201303090328.38621.lindner_marek@yahoo.de>
 <513A3F2A.8090601@universe-factory.net>
In-Reply-To: <513A3F2A.8090601@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303090406.42605.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: make number of
	broadcasts configurable per hardif
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Saturday, March 09, 2013 03:42:34 Matthias Schiffer wrote:
> > In general, I like the idea but the approach isn't the best. Can't we
> > automate these settings instead of adding hundreds of little knobs
> > nobody will understand ? Why not detecting wifi interfaces as such and
> > configure the broadcast value accordingly ? The same goes for ethernet /
> > vpns ?
> 
> While is makes sense to find some sensible defaults for such values, in
> my opinion everything should be as configurable as possible. I don't
> think it would be a problem to have some dozens knobs more if a normal
> user almost never has to touch them. On the other hand, for testing,
> debugging and development purposes, it can save a lot of time not having
> to recompile the kernel for such changes all the time.

Knobs only used for debugging and development should never go into sysfs. User 
space APIs are created for life time. Once it is there and we submit it to the 
kernel the API has to stay and has to be supported forever.


> Also, for VPN connections, automatic detection of the link type isn't
> generally possible, as we'd have to know which medium the VPN is going
> over...

You are running batman-adv over VPN links on top of wifi interfaces ?

Cheers,
Marek
