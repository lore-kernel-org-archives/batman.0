Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 7 Mar 2013 14:27:27 +0800
References: <1361959096-30522-1-git-send-email-linus.luessing@web.de>
 <201303031306.41769.lindner_marek@yahoo.de>
In-Reply-To: <201303031306.41769.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201303071427.27817.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix broadcast+ogm queue
	purging race condition
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

On Sunday, March 03, 2013 13:06:41 Marek Lindner wrote:
> On Wednesday, February 27, 2013 17:58:15 Linus L=C3=BCssing wrote:
> > +/**
> > + * batadv_canceled_packets_free - Frees canceled forward packets
> > + * @head:      A list of to be freed forw_packets
> > + *
> > + * This function canceles the scheduling of any packet in the provided
> > list, + * waits for any possibly running packet forwarding thread to
> > finish and + * finally, safely frees this forward packet.
> > + *
> > + * This function might sleep.
> > + */
> > +static void batadv_canceled_packets_free(struct hlist_head *head)
> > +{
> > +       struct batadv_forw_packet *forw_packet;
> > +       struct hlist_node *tmp_node, *safe_tmp_node;
> > +
> > +       hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
> > head, +                                 canceled_list) {
> > +               cancel_delayed_work_sync(&forw_packet->delayed_work);
> > +
> > +               hlist_del(&forw_packet->canceled_list);
> > +               batadv_forw_packet_free(forw_packet);
> > +       }
> > +}
>=20
> I don't quite see how your patch can work when only one interface is
> deactivated and not the mesh as a whole. batadv_purge_outstanding_packets=
()
> also is called from batadv_hardif_disable_interface() in which case the
> broadcast packets re-arm themselves by appending the work item to their
> respective queues. That is why we have the magic "pending" check in the
> cleanup functions.

One idea could be to check the incoming interface status in=20
batadv_send_outstanding_bcast_packet() right below the mesh status check. I=
f=20
the interface is going down we could exit immdiately. This could be even a=
=20
better solution than the pending check we have today.

Cheers,
Marek
