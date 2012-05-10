Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 May 2012 12:49:15 +0800
References: <1336561976-16088-1-git-send-email-ordex@autistici.org>
	<1336561976-16088-12-git-send-email-ordex@autistici.org>
In-Reply-To: <1336561976-16088-12-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205101249.16267.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 11/14] batman-adv: Adding hard_iface
	specific sysfs wrapper macros for UINT
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

On Wednesday, May 09, 2012 19:12:53 Antonio Quartulli wrote:
> From: Linus Luessing <linus.luessing@web.de>
> 
> This allows us to easily add a sysfs parameter for an unsigned int
> later, which is not for a batman mesh interface (e.g. bat0), but for a
> common interface instead. It allows reading and writing an atomic_t in
> hard_iface (instead of bat_priv compared to the mesh variant).
> 
> Developed by Linus during a 6 months trainee study period in Ascom
> (Switzerland) AG.

Antonio, you merged 2 patches that are not to be merged. Any idea why you 
squashed 4e18e833bb5a06ab0462c3071f733dffb2a752ee and 
f76d019194e0a88c57371df169ecc979690a04c2 into a single patch ?

Regards,
Marek
