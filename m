Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 30 Nov 2016 22:53:27 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20161130195327.GA10274@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [bug report] batman-adv: make the TT CRC logic VLAN
	specific
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: antonio@open-mesh.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hello Antonio Quartulli,

The patch 7ea7b4a14275: "batman-adv: make the TT CRC logic VLAN
specific" from Jul 30, 2013, leads to the following static checker
warning:

	net/batman-adv/translation-table.c:3294 batadv_send_my_tt_response()
	error: uninitialized symbol 'tt_change'.

net/batman-adv/translation-table.c
  3282          if (!full_table) {
  3283                  spin_lock_bh(&bat_priv->tt.last_changeset_lock);
  3284  
  3285                  tt_len = bat_priv->tt.last_changeset_len;
  3286                  tvlv_len = batadv_tt_prepare_tvlv_local_data(bat_priv,
  3287                                                               &tvlv_tt_data,
  3288                                                               &tt_change,
  3289                                                               &tt_len);
  3290                  if (!tt_len)
  3291                          goto unlock;

This should probably be changed to:

			if (!tt_len || !tvlv_len)
				goto unlock;

There seems to be an assumption that "tt_len" is set to zero on the
error path?  That's another way to fix this, I suppose.

  3292  
  3293                  /* Copy the last orig_node's OGM buffer */
  3294                  memcpy(tt_change, bat_priv->tt.last_changeset,
  3295                         bat_priv->tt.last_changeset_len);
  3296                  spin_unlock_bh(&bat_priv->tt.last_changeset_lock);
  3297          } else {

See also:

	net/batman-adv/translation-table.c:3313 batadv_send_my_tt_response()
	error: uninitialized symbol 'tt_change'.

regards,
dan carpenter
