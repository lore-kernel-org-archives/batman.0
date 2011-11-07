Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 7 Nov 2011 20:00:12 +0800
References: <1320666759-11791-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1320666759-11791-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201111072000.12918.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Human readable log levels
	instead of bitmasks
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

On Monday, November 07, 2011 19:52:39 Martin Hundeb=F8ll wrote:
> As the number of log levels increases, it becomes less user friendly to
> assign a log level, as this is given as a bitmask in decimal form. This
> commit changes this, so that one or more log levels can be given as
> human readable words (e.g. "batctl ll batman routes").

The "Signed-off-by" is missing.


> +		snprintf(str, 4, "%u", log_level);
> +		res =3D write_file(path_buff, SYS_LOG_LEVEL, str, NULL);

Shouldn't it be "sizeof(str)" instead of "4" and "%i" instead of "%u" ?

Regards,
Marek
