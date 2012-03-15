Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 15 Mar 2012 14:48:19 +0800
References: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
	<1331417873-19354-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1331417873-19354-4-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201203151448.20517.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Adding hard_iface
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

On Sunday, March 11, 2012 06:17:52 Marek Lindner wrote:
> From: Linus Luessing <linus.luessing@web.de>
> 
> This allows us to easily add a sysfs parameter for an unsigned int
> later, which is not for a batman mesh interface (e.g. bat0), but for a
> common interface instead. It allows reading and writing an atomic_t in
> hard_iface (instead of bat_priv compared to the mesh variant).
> 
> Developed by Linus during a 6 months trainee study period in Ascom
> (Switzerland) AG.

Applied in revision 4e18e83.

Thanks,
Marek
