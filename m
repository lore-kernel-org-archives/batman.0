Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 15 Oct 2010 18:06:09 +0200
References: <1286922125-18097-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286922125-18097-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201010151806.09666.lindner_marek@yahoo.de>
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
> Simon's idea so far was, to introduce a debug/ folder in sysfs which is
> hidden by default and could be enabled with a KConfig option, so that
> tinkerers still have a chance for their needs for tweaking parameters.
> num_bcasts would probably be one of the first candidates as a
> debug-parameter.

I think that is a good compromise. However, the kernel folks might not like=
=20
the idea of having such "volatile" options within the /sys file system or d=
oes=20
anyone know existing code behaving in a similar fashion ?
How about making this debug folder available inside our debugfs entry ?

Cheers,
Marek
