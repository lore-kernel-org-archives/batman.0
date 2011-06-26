Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 26 Jun 2011 13:36:16 +0200
References: <1308319887-2117-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1308319887-2117-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201106261336.16840.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: unify flags for
	tt_change/tt_local_entry/tt_global_entry
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

On Friday, June 17, 2011 04:11:27 PM Antonio Quartulli wrote:
> The tt_local_entry structure now has a 'flags' field. This helps to
> unify the flags format to all the client related structures
> (tt_global_entry and tt_change). The 'never_purge' field is now encoded in
> the 'flags' one.
> 
> Moreover 'enum tt_change_flags' is now called 'enum tt_client_flags' and
> the defined values apply to the tt_local_entry, tt_global_entry and the
> tt_change 'flags' field.

Applied in revision 763a3c2.

Thanks,
Marek
