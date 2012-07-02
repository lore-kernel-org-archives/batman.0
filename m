Return-Path: <martin@hundeboll.net>
Message-ID: <4FF1574B.2040506@hundeboll.net>
Date: Mon, 02 Jul 2012 10:09:47 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1341144314-20995-1-git-send-email-sven@narfation.org>
In-Reply-To: <1341144314-20995-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Split batadv_priv in
 sub-structures for features
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

Hi Sven,

On 07/01/2012 02:05 PM, Sven Eckelmann wrote:
> The structure batadv_priv grows everytime a new feature is introduced. It gets
> hard to find the parts of the struct that belongs to a specific feature. This
> becomes even harder by the fact that not every feature uses a prefix in the
> member name.
>
> The variables for bridge loop avoidence, gateway handling, translation table
> and visualization server are moved into separate structs that are included in
> the bat_priv main struct.

Great job!

> Signed-off-by: Sven Eckelmann<sven@narfation.org>
> ---
> Any other ideas for substructs?

I will definitely add a substruct for the catwoman feature as well. How aboug tt-entries in struct batadv_orig_node?

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net


