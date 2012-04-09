Return-Path: <martin@hundeboll.net>
Message-ID: <4F83146E.2080609@hundeboll.net>
Date: Mon, 09 Apr 2012 18:55:10 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1333543332-26942-1-git-send-email-ordex@autistici.org>
	<1333543332-26942-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1333543332-26942-4-git-send-email-ordex@autistici.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: let
 tt_global_entry_has_orig() return the orig_entry or NULL instead of 1 or 0
 only
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Antonio,

On 04/04/2012 02:42 PM, Antonio Quartulli wrote:

>   	rcu_read_lock();
>   	head =&entry->orig_list;
>   	hlist_for_each_entry_rcu(tmp_orig_entry, node, head, list) {
>   		if (tmp_orig_entry->orig_node == orig_node) {
> -			found = true;
> +			orig_entry = tmp_orig_entry;
>   			break;
>   		}
>   	}
>   	rcu_read_unlock();
> -	return found;
> +	return orig_entry;
>   }

I'm not that well into the tt code, but shouldn't there be some reference counting when handing pointers round like this?

-- 
Kind regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C

+45 61 65 54 61
martin@hundeboll.net
