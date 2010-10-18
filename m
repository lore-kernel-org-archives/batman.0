Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 18 Oct 2010 12:06:01 +0200
References: <1286922125-18097-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286922125-18097-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201010181206.02350.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Simplifying sysfs code
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

On Wednesday 13 October 2010 00:22:01 Linus L=C3=BCssing wrote:
> thanks for all the feedback for the changes I wanted to make to the sysfs
> code base. I tried to address bugs and suggestions. The macros are now a
> bit smaller than in the beginning, the missing static has been added
> (thanks Andrew and Sven).
>=20
> Due to Marecs comment on the issues with changing sysfs file names in the
> kernel (which I was not aware of, thanks for explaining) and comments
> about old sysfs filenames being more descriptive, I changed the bat_priv
> names instead now. I don't really see a good reason yet why they should
> not be equal.

Patches 1-4 have been applied (revision 1833-1836).

Thanks,
Marek
