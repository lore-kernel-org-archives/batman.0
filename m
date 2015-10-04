Return-Path: <dominik@heidler.eu>
From: Dominik Heidler <dominik@heidler.eu>
Message-ID: <56113660.8080506@heidler.eu>
Date: Sun, 4 Oct 2015 16:23:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Alfred update-command
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

Hi,

I tried to use the alfred update-command but it seems that the
update-command is only triggered when data is purged but not when new
data is received.

The changed_data_type() method is only called from the purge_data() method.

169     while (NULL != (hashit = hash_iterate(globals->data_hash,
hashit))) {
170         struct dataset *dataset = hashit->bucket->data;
171
172         time_diff(&now, &dataset->last_seen, &diff);
173         if (diff.tv_sec < ALFRED_DATA_TIMEOUT)
174             continue;
175
176         changed_data_type(globals, dataset->data.header.type);

177
178         hash_remove_bucket(globals->data_hash, hashit);
179         free(dataset->buf);
180         free(dataset);
181     }


Is this the way the update-command should work or am I doing something
wrong?

Regards,
Dominik Heidler
