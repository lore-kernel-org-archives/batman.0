Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 23 Jun 2010 18:00:13 +0200
References: <201006231620.11058.lindner_marek@yahoo.de>
	<1277302839-20197-1-git-send-email-lindner_marek@yahoo.de>
	<201006231717.35877.sven.eckelmann@gmx.de>
In-Reply-To: <201006231717.35877.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201006231800.14434.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: add routing debug log
	accessible via debugfs
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Wednesday 23 June 2010 17:17:27 Sven Eckelmann wrote:
> Can you please change that (at least the 'null' function) from a define to
> an static inline function? Otherwise there are a lot of "unused" warning
> when compiling without debug support.
> 
> static inline void bat_dbg(char type __attribute__((unused)),
> 			   struct bat_priv *bat_priv __attribute__((unused)),
> 			   char *fmt __attribute__((unused)), ...)
> { }

Sure, will do.


> To you suggestion to add more information from kernel log to the debug log
> - it seems to be interesting, but we must ensure that those information
> are specific to a mesh device. I will sent a patch which modifies all
> printks later. Maybe we could discuss where it would be a benefit and
> where it is not needed (~54 printks are for discussion).

Yes, sounds good.

Regards,
Marek
