Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 9 Mar 2013 18:07:11 +0800
References: <1362764336-1591-1-git-send-email-linus.luessing@web.de>
 <201303090406.42605.lindner_marek@yahoo.de>
 <513A5D27.7020506@universe-factory.net>
In-Reply-To: <513A5D27.7020506@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303091807.11660.lindner_marek@yahoo.de>
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

On Saturday, March 09, 2013 05:50:31 Matthias Schiffer wrote:
> You have a point there... While I still think making the broadcast count
> adjustable makes sense, I'd also be happy to get a patch accepted that
> just sets the broadcast count depending on the interface type.
> 
> My current plan is:
> 
> * WLAN devices: 3 broadcasts
> * Everything else: 1 broadcast
> 
> Any additional types that should be considered?

Sounds good to me.

Cheers,
Marek
