Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 18 Feb 2011 13:31:04 +0100
References: <201102141435.27624.lindner_marek@yahoo.de>
In-Reply-To: <201102141435.27624.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201102181331.05302.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] renaming batman_if
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

On Monday 14 February 2011 14:35:27 Marek Lindner wrote:
> due to popular request I'm proposing 2 patches to rename "batman_if" to
> "hard_iface". The former was rather confusing/misleading whereas the latter
> expresses its function clearly.
> 
> Note: As this struct is used all over the code it will create quite a
> rebase effort for everyone with external patches. Keep in mind that "sed"
> is your friend.  ;-)

Applied in revision 1951-1952.

Regards,
Marek
