Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 2 Nov 2011 01:38:14 +0100
References: <1319973453-24753-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1319973453-24753-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201111020138.14590.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: create a common substructure
	for tt_global/local_entry
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

On Sunday, October 30, 2011 12:17:33 Antonio Quartulli wrote:
> Several functions in the translation table management code assume that the
> tt_global_entry and tt_local_entry structures have the same initial fields
> such as 'addr' and 'hash_entry'. To improve the code readability and to
> avoid mistakes in later changes, a common substructure that substitute the
> shared fields has been introduced (struct tt_common_entry).
> 
> Thanks to this modification, it has also been possible to slightly reduce
> the code length by merging some functions like compare_ltt/gtt() and
> tt_local/global_hash_find()

Applied in revision 17fe5c5.

Thanks,
Marek
