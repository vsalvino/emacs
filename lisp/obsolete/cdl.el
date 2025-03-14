;;; cdl.el --- Common Data Language (CDL) utility functions for GNU Emacs -*- lexical-binding: t -*-

;; Copyright (C) 1993, 2001-2025 Free Software Foundation, Inc.

;; Author: Ata Etemadi <ATAE@spva.physics.imperial.ac.uk>
;; Maintainer: emacs-devel@gnu.org
;; Keywords: data
;; Obsolete-since: 31.1

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This library is obsolete.
;;
;; Use `shell-command' and `shell-command-on-region' instead.

;;; Code:

(defun cdl-get-file (filename)
  "Run file through ncdump and insert result into buffer after point."
  (interactive "fCDF file: ")
  (message "ncdump in progress...")
  (let ((start (point)))
    (call-process  "ncdump" nil t nil (expand-file-name filename))
    (goto-char start))
  (message "ncdump in progress...done"))

(defun cdl-put-region (filename start end)
  "Run region through ncgen and write results into a file."
  (interactive "FNew CDF file: \nr")
  (message "ncgen in progress...")
  (call-process-region start end "ncgen"
		       nil nil nil "-o" (expand-file-name filename))
  (message "ncgen in progress...done"))

(provide 'cdl)

;;; cdl.el ends here
