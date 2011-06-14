Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 14 Jun 2011 14:59:26 +0200
References: <1307986680-21113-1-git-send-email-ordex@autistici.org>
	<1307998300-5898-1-git-send-email-sven@narfation.org>
In-Reply-To: <1307998300-5898-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201106141459.27162.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: clean up the tt_query
	flags field
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

On Monday, June 13, 2011 10:51:40 PM Sven Eckelmann wrote:
> From: Antonio Quartulli <ordex@autistici.org>
> 
> The tt_query subtype is represented by the two leading bits (lsb) of
> the tt_query->flags field. Therefore it cannot be handled by simple
> "flags" but by two bits wide integer. The TT_QUERY_TYPE_MASK is used to
> extract the relevant bits that can be compared to the related enum
> values (TT_RESPONSE, TT_REQUEST)

Applied in revision 02585b0.

Thanks,
Marek
