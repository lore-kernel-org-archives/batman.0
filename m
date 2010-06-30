Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 30 Jun 2010 21:35:49 +0200
References: <1277920995-25503-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1277920995-25503-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201006302135.50499.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Add timeout filtering option for
	originators
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

On Wednesday 30 June 2010 20:03:13 Linus L=C3=BCssing wrote:
> +	char msecs_buff[4];
> +	memset(msecs_buff, '0', sizeof(msecs_buff));
> +	msecs_buff[3] =3D '\0';

Shouldn't a simple=20
memset(msecs_buff, 0, sizeof(msecs_buff));
be enough ?



> +			if (sscanf(optarg, "%3d.%3s", &orig_timeout_secs,
> +			else if (sscanf(optarg, "%3d", &orig_timeout_secs) =3D=3D 1) { ; }
> +			else {

I don't quite understand the sense of the "else if" here. You could also=20
write:
else if (sscanf(optarg, "%3d", &orig_timeout_secs) !=3D 1)
and write no else block but I don't see why 1 second should be accepted and=
=20
nothing else ?

Regards,
Marek
