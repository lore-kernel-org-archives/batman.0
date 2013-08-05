Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 5 Aug 2013 16:36:18 +0800
References: <1375447495-31820-1-git-send-email-linus.luessing@web.de>
 <1375447495-31820-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1375447495-31820-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201308051636.19197.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next] batman-adv: fix potential kernel
	paging errors for unicast transmissions
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

On Friday, August 02, 2013 20:44:55 Linus L=C3=BCssing wrote:
> There are several functions which might reallocate skb data. Currently
> some places keep reusing their old ethhdr pointer regardless of whether
> they became invalid after such a reallocation or not. This potentially
> leads to kernel paging errors.
>=20
> This patch fixes these by refetching the ethdr pointer after the
> potential reallocations.

As discussed on IRC, please fix a similar problem in=20
batadv_gw_is_dhcp_target(). I know this bug wasn't created by your patch bu=
t I=20
found it while reviewing your code and looking for similar cases. Should be=
=20
simple to fix as well.


> @@ -326,7 +326,9 @@ static bool batadv_unicast_push_and_fill_skb(struct
> sk_buff *skb, int hdr_size, * @skb: the skb containing the payload to
> encapsulate
>   * @orig_node: the destination node
>   *
> - * Returns false if the payload could not be encapsulated or true
> otherwise +=20
> * Return false if the payload could not be encapsulated or
> true otherwise.=20

Don't change "returns" to "return".


> @@ -343,7 +345,9 @@ static bool batadv_unicast_prepare_skb(struct sk_buff
> *skb, * @orig_node: the destination node
>   * @packet_subtype: the batman 4addr packet subtype to use
>   *
> - * Returns false if the payload could not be encapsulated or true
> otherwise +=20
> * Return false if the payload could not be encapsulated or
> true otherwise.

Same here.

Cheers,
Marek
