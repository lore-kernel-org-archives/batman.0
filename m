Return-Path: <ordex@autistici.org>
Date: Tue, 1 Nov 2011 10:12:03 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111101091202.GB20215@ritirata.org>
References: <1319964962-5092-1-git-send-email-ordex@autistici.org>
	<1319964962-5092-2-git-send-email-ordex@autistici.org>
	<20111031000546.GC10726@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20111031000546.GC10726@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: implement an helper
 function to forge unicast packets
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

On Mon, Oct 31, 2011 at 01:05:46AM +0100, Simon Wunderlich wrote:
> On Sun, Oct 30, 2011 at 09:55:57AM +0100, Antonio Quartulli wrote:
> > -find_router:
> > +prepare_packet:
> >  	/**
> >  	 * find_router():
> 
> I guess the comment should be changed as well when the label is renamed.

Actually this comment refers to the function below, not to the label.

> 
> >  	 *  - if orig_node is NULL it returns NULL
> >  	 *  - increases neigh_nodes refcount if found.
> >  	 */
> >  	neigh_node = find_router(bat_priv, orig_node, NULL);
> > -
> 
> Do we really need to remove this newline?
>

Don't think so ;)

Thanks,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
