Return-Path: <paukoning@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1353931112-17392-1-git-send-email-sven@narfation.org>
References: <1353931112-17392-1-git-send-email-sven@narfation.org>
Date: Mon, 24 Dec 2012 15:25:05 +0100
Message-ID: <CANiGF99LYEYtvm_Cgw_pobiCN_J=hm3VKLwntthkXp7HGUYe1g@mail.gmail.com>
From: Pau Koning <paukoning@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/5] batman-adv: Use common Jenkins
	Hash implementation
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Mon, Nov 26, 2012 at 12:58 PM, Sven Eckelmann <sven@narfation.org> wrote:
> An unoptimized version of the Jenkins one-at-a-time hash function is copied all
> over the code wherever an hashtable is used. Instead the optimized version
> shared between the whole kernel should be used to reduce code duplication and
> keep bugs at a single point.
>
> Only the DAT code must use the old implementation because it is used as
> distributed hash function which has to be common for all nodes.

Here happened something similar. This patchset was discussed and not
rejected. But it wasn't accepted either and as result didn't appear in
3.8-rc1.
