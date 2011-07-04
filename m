Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 4 Jul 2011 14:29:00 +0200
References: <1309127157-32507-1-git-send-email-ordex@autistici.org>
	<1309389240-11486-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1309389240-11486-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201107041429.01210.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: split
	tt_local/global_entry flags field for local and remote computations
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

On Thursday, June 30, 2011 01:13:59 Antonio Quartulli wrote:
> The tt_global/local_entry 'flags' field contains flags used either for
> local and remote computations. To optimise the usage of this field, its
> length has been increased to 16bit in order to use the eight leading bits
> (from 0 to 7) to store flags that have to be sent on the wire, while the
> eight ending ones are used for local computation only.

Applied in revision 68f78c7.

Thanks,
Marek
