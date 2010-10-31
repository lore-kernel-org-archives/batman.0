Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 31 Oct 2010 16:10:41 +0100
References: <201010240313.35215.lindner_marek@yahoo.de>
	<201010301414.06280.sven.eckelmann@gmx.de>
In-Reply-To: <201010301414.06280.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201010311610.42160.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv gateway handling
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

On Saturday 30 October 2010 14:14:02 Sven Eckelmann wrote:
> > -       struct gw_node *gw_node;
> > -       struct hlist_node *node, *node_tmp;
> > +                                 &bat_priv->gw_list, list) {
> > +               if (((!gw_node->deleted) ||
> > +                    (time_after(jiffies, gw_node->deleted + timeout)))
> > && +                   atomic_read(&bat_priv->mesh_state) ==
> > MESH_ACTIVE) +                       continue;
> 
> This should be time_before.

Agreed.


> > -                             char *buff, size_t count)
> > +                            char *buff, size_t count)
> 
> Why was the space removed?

Should I move this into a separate patch ?


> > +               if ((strnicmp(tmp_ptr, "kbit", 4) == 0) ||
> > +                       (multi > 1))
> 
> Why this indentation? And This should be on a single line (or I count
> wrong).

No, you are right. Will be fixed.


> > +       if ((gw_mode_tmp == GW_MODE_CLIENT) &&
> > +           (atomic_read(&bat_priv->gw_sel_class) == 0))
> > +               atomic_set(&bat_priv->gw_sel_class, 20);
> > +
> > +       if ((gw_mode_tmp == GW_MODE_SERVER) &&
> > +           (atomic_read(&bat_priv->gw_bandwidth) == 0))
> > +               atomic_set(&bat_priv->gw_bandwidth, 41);
> 
> Why setting that here? And why do you set gw_sel_class here to 20 (if it is
> 0 before) and in softif_create to 0? Shouldn't it be set to 20 in
> softif_create instead?

The general idea was that if somebody activated client or gateway mode without 
setting gw_sel_class or gw_bandwidth to any value, it would use some default 
values. 
Moving these checks into softif_create() would only solve half of the problem 
because a user could set these variables to 0 and then start the client or 
server. At least the client mode requires the gw_sel_class variable value to 
be greater than 0.

Thanks for the comments,
Marek
