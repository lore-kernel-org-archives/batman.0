Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 30 Jul 2012 11:47:03 +0200
References: <1343603730-3824-1-git-send-email-ordex@autistici.org>
 <201207300959.16852.lindner_marek@yahoo.de>
 <20120730092343.GF2578@ritirata.org>
In-Reply-To: <20120730092343.GF2578@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201207301147.03506.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: pass the WIFI flag from the
	local to global entry
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

On Monday, July 30, 2012 11:23:43 Antonio Quartulli wrote:
>   On Mon, Jul 30, 2012 at 09:59:16AM +0200, Marek Lindner wrote:
> > On Monday, July 30, 2012 01:15:30 Antonio Quartulli wrote:
> > > in case of client roaming a new global entry is added while a
> > > corresponding local one is still present. In this case the node can
> > > safely pass the WIFI flag from the local to the global entry
> >
> > And why would we want that ?
> 
> To let the AP-isolation work. If a client is known to be WIFI and we do not
> "pass" this flag on roaming, we end up in a state where this client is not
> marked as WIFI anymore (even if it should be).
> 
> During this time period the client will be able to talk to the other WIFI
> clients even if the AP isolation is enabled

And why is this explanation not part of the commit message ?

Regards,
Marek
