Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 16 Oct 2011 19:12:36 +0200
References: <1318425058-715-1-git-send-email-ordex@autistici.org>
	<1318425058-715-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1318425058-715-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201110161912.37335.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: check for tt_reponse
	real length
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

On Wednesday, October 12, 2011 15:10:58 Antonio Quartulli wrote:
> if (tt_query->flags & TT_FULL_TABLE)
> +                               tt_len =3D tt_query->tt_data * ETH_ALEN;

Odd, I had the feeling the full table also uses 'struct tt_change' and not=
=20
plain ethernet addresses anymore.

=46rom translation-table.c (send_my_tt_response):
tt_len =3D (uint16_t)atomic_read(&bat_priv->num_local_tt) *=20
                              sizeof(struct tt_change);

Regards,
Marek
