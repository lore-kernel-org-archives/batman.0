Return-Path: <gio@eigenlab.org>
From: Gio <gio@eigenlab.org>
Date: Sun, 01 Mar 2015 10:09:46 +0100
Message-ID: <95034253.ejT9KvNpcM@giomium>
In-Reply-To: <1425199578-6392-1-git-send-email-sven@narfation.org>
References: <1425199578-6392-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Use common Jenkins Hash
	implementation
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

On Sunday, March 01, 2015 09:46:18 AM Sven Eckelmann wrote:
> Only the DAT code must use the old implementation because it is used as
> distributed hash function which has to be common for all nodes.

Does the kernel shared version change behavior often across kernel versions ?
