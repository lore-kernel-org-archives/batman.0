Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 27 Jan 2011 13:37:57 +0100
References: <1296052208-6041-1-git-send-email-lindner_marek@yahoo.de>
	<201101261602.38873.sven@narfation.org>
In-Reply-To: <201101261602.38873.sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201101271337.58236.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: add raw wifi packet
	decapsulation support
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

On Wednesday 26 January 2011 16:02:32 Sven Eckelmann wrote:
> Didn't we say yesterday that we must either use ntohs or only read the
> first byte of the framecontrol? The last option which comes to my mind is
> to define IEEE80211_FCTL_FTYPE and IEEE80211_FTYPE_DATA for big and little
> endian independently.

I must have misunderstood something but you are right - I'm going to change it 
and publish a second patch.


> > +       if (fc & IEEE80211_STYPE_QOS_DATA)
> > +               hdr_len += 2;
> 
> Here are you testing only on bit. Are you sure that the other 3 bits aren't
> interesting? At least one combination isn't well defined by the 802.11
> standard from 2007 and some others are null data types.

I'd claim we only care if it is QoS or not because all QoS packets have a 
longer header (QoS control field). 
The spec says: "bit 7 is set to 1 in the QoS data subtypes, which have QoS 
Control fields in their MAC headers"

Regards,
Marek
