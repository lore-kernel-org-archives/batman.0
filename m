Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 15 Dec 2012 16:54:53 +0800
References: <1355513344-16066-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1355513344-16066-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201212151654.53276.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: postpone OGM preparation to
	sending time
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Saturday, December 15, 2012 03:29:04 Antonio Quartulli wrote:
> OGMs are currently prepared 1 originator interval in advance
> then the time they are used to be sent. This means that once
> in the air they carry old information (like TT announcements
> and possibly other flags).
> 
> To fix this, postpone the OGM creation to the same time of
> sending, in this way the OGM is first created and then
> immediately sent.
> 
> This patch also removes a "magic" -2 operation that was
> introduced in the past to address the fact that batman-adv
> was sending "delayed OGM" plus the fact that the OGM seqno
> was increased right after having sent a new packet. Since
> this change is removing both the behaviours, the "magic"
> operation is not needed anymore.

Where is the kernel doc ?  :)

Cheers,
Marek
