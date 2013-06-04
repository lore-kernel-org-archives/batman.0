Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 4 Jun 2013 17:14:52 +0800
References: <179dd3afbd3ecdcd2144bd3016e1b01eaf0d5263.1369754967.git.mschiffer@universe-factory.net>
 <20130528154248.GD14466@pandem0nium>
In-Reply-To: <20130528154248.GD14466@pandem0nium>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306041714.52831.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: wait for rtnl in
	batadv_store_mesh_iface instead of failing if it is taken
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Tuesday, May 28, 2013 23:42:48 Simon Wunderlich wrote:
>   On Tue, May 28, 2013 at 05:32:32PM +0200, Matthias Schiffer wrote:
> > The rtnl_lock in batadv_store_mesh_iface has been converted to a
> > rtnl_trylock some time ago to avoid a possible deadlock between rtnl and
> > s_active on removal of the sysfs nodes.
> >
> > The behaviour introduced by that was quite confusing as it could lead to
> > the sysfs store to fail, making batman-adv setup scripts unreliable. As
> > recently the sysfs removal was postponed to a worker not running with
> > the rtnl taken, the deadlock can't occur any more and it is safe to
> > change the trylock back to a lock to make the sysfs store reliable
> > again.
> >
> > Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Reviewed-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Applied in revision 96cd772.

Thanks,
Marek
