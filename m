Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 11 Jun 2011 12:07:17 +0200
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
	<1304946150-6026-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1304946150-6026-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201106111207.18089.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/3] batman-adv: add wrapper function
	to throw uevent in userspace
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

On Monday, May 09, 2011 03:02:28 PM Antonio Quartulli wrote:
> Using throw_uevent() is now possible to trigger uevent signal that can
> be recognised in userspace. Uevents will be triggered through the
> /devices/virtual/net/{MESH_IFACE} kobject.
> 
> A triggered uevent has three properties:
> - type: the event class. Who generates the event (only 'gw' is currently
>   defined). Corresponds to the BATTYPE uevent variable.
> - action: the associated action with the event ('add'/'change'/'del' are
>   currently defined). Corresponds to the BAACTION uevent variable.
> - data: any useful data for the userspace. Corresponds to the BATDATA
>   uevent variable.

Applied in revision d2586d6.

Thanks,
Marek
