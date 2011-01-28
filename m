Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 28 Jan 2011 21:14:33 +0100
References: <1296052208-6041-1-git-send-email-lindner_marek@yahoo.de>
	<201101271327.58266.lindner_marek@yahoo.de>
	<20110128172416.GW23716@lunn.ch>
In-Reply-To: <20110128172416.GW23716@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201101282114.34758.lindner_marek@yahoo.de>
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

On Friday 28 January 2011 18:24:16 Andrew Lunn wrote:
> So i was expecting to see something like DSTODS. However the madwifi
> macros are for the complete DIR field, where as you are looking at
> individual bits. So 
> 
> (fc & IEEE80211_FCTL_FROMDS) && (fc & IEEE80211_FCTL_TODS) 
> 
> is equivalent to the madwifi IEEE80211_FC1_DIR_DSTODS.
> 
> So you header length calculation looks O.K.

I rather discuss potential bugs even if they turn out not to be bugs instead 
of letting them through.  :)

Thanks for your review,
Marek
