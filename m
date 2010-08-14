Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 14 Aug 2010 23:32:27 +0200
References: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
	<1281820085-13507-9-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281820085-13507-9-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201008142332.28067.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 9/9] batman-adv: Don't increase mtu of
	interface automatically
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

On Saturday 14 August 2010 23:08:05 Sven Eckelmann wrote:
> The user usually sets a mtu by hand and don't want to have software to
> change it automatically. This is only needed when we must reduce the mtu
> due to a low mtu of an active slave device, but we should not increase
> it when any other action is made on the system related to the used
> interfaces.

I fear that this might lead to a strange user experience. If the mtu on batX 
wasn't set explicitely but the mtu of an interface used by batman is increased 
while batman uses it the user has to know that he/she now needs to manually 
modify the batX mtu before it becomes effective.

What about a flag which remembers whether the mtu on batX was modified by the 
user. If so, batman-adv does not increase the mtu otherwise we keep the 
current behaviour ?

Regards,
Marek
