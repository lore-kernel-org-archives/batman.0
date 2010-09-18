Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 18 Sep 2010 17:41:43 +0200
References: <1284738065-8715-10-git-send-email-sven.eckelmann@gmx.de>
	<201009181642.08297.lindner_marek@yahoo.de>
	<201009181721.44244.sven.eckelmann@gmx.de>
In-Reply-To: <201009181721.44244.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201009181741.44238.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 9/9] batman-adv: count batman_if list
	queries as reference
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

On Saturday 18 September 2010 17:21:43 Sven Eckelmann wrote:
> As said before, this patch should not count primary_if by design (see the 
> commit message). I would say that your changes should be an extra patch.
> 
> I will split that stuff and send it as extra patches. Your patch itself
> has  the problem that it increases the refcnt through
> get_active_batman_if, but doesn't reduce it at the end.

Should be ok now - I submitted your patches (revision 1799-1809).

Thanks,
Marek
