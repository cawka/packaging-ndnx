/*
 * A NDNx library test.
 *
 * Portions Copyright (C) 2013 Regents of the University of California.
 * 
 * Based on the CCNx C Library by PARC.
 * Copyright (C) 2008, 2009, 2012, 2013 Palo Alto Research Center, Inc.
 *
 * This work is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License version 2 as published by the
 * Free Software Foundation.
 * This work is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
 * for more details. You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

package org.ndnx.ndn.repo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.ndnx.ndn.NDNHandle;
import org.ndnx.ndn.impl.NDNFlowControl;
import org.ndnx.ndn.impl.repo.RepositoryException;
import org.ndnx.ndn.io.content.ContentEncodingException;
import org.ndnx.ndn.protocol.ContentName;
import org.ndnx.ndn.protocol.ContentObject;

/**
 * Part of repository test infrastructure.
 */
public class RepoSingleFileTester extends RepoPerformanceTester {

	private static RepoSingleFileTester _rpt = new RepoSingleFileTester();
	private static TestFlowControl _tfc = null;

	private class TestFlowControl extends NDNFlowControl {

		private FileOutputStream _fos = null;

		public TestFlowControl(String repoName, ContentName name, NDNHandle handle)
				throws RepositoryException, IOException {
			super(name, handle);
			_tfc = this;
			if (repoName != null) {
				File file = new File(repoName + "/" + "repoFile");
				try {
					File repoDir = new File(repoName);
					repoDir.mkdirs();
					file.createNewFile();
					_fos = new FileOutputStream(file);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		}

		@Override
		public ContentObject put(ContentObject co) throws IOException {
			if (_fos != null) {
				try {
					_fos.write(co.encode());
				} catch (ContentEncodingException e) {
					e.printStackTrace();
				}
			}
			return co;
		}
	}

	public RepoSingleFileTester() {}

	public RepoSingleFileTester(String repoName, ContentName name, NDNHandle handle)
			throws IOException, RepositoryException {
		super(name, _rpt.new TestFlowControl(repoName, name, handle));
	}

	@Override
	public RepoPerformanceTester getTester(String repoName, ContentName name, NDNHandle handle)
			throws IOException, RepositoryException {
		return new RepoSingleFileTester(repoName, name, handle);
	}

	@Override
	public void close() throws IOException {
		super.close();
		if (_tfc._fos != null)
			_tfc._fos.close();
	}

	public static void main(String[] args) {
		_rpt.doTest(args);
	}

}
