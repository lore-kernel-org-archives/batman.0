Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jun 2016 10:22:19 +0200
Message-ID: <1882846.Rj7N00o9iY@sven-desktop>
In-Reply-To: <1464041662-639-1-git-send-email-linus.luessing@c0d3.blue>
References: <1464041662-639-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Refactor forward packet
	creation/destruction
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

On Tuesday 24 May 2016 00:14:22 Linus L=C3=BCssing wrote:
[...]
> Zombie patch - rotten & dead since 2013, but w{al,or}ks again!

Look! It's moving. It's alive. It's alive... It's alive, it's moving, i=
t's=20
alive, it's alive, it's alive, it's alive, IT'S ALIVE!

Thanks for resurrecting it :)

[...]
> +/**
> + * batadv_forw_packet_alloc - Allocates a forwarding packet
[...]
> + * On success, returns the allocated forwarding packet. Otherwise re=
turns
> + * NULL.
> + */

Please change it to the format which kernel-doc can parse. "Return: ...=
"

Kind regards,
=09Sven

